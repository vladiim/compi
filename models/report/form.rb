module Report
  class Form
    attr_reader :email, :site, :subscription
    def initialize(email, site, subscription = 0)
      @email        = email
      @site         = site
      @subscription = subscription
    end

    attr_reader :user, :business
    def process
      @user     = find_or_create_user
      @business = user.add_business(url: site)
      send_thank_you_mail
    end

    def valid?
      email? && site?
    end

    def errors
      return {} if valid?
      email_m = { email: 'not an email' }
      site_m  = { site: 'not a URL' }
      return email_m.merge(site_m) unless email? || site?
      return email_m unless email?
      site_m unless site?
    end

    def message
      Copy::Report.thank_you_page(email, site)
    end

    private

    def email?
      !VALID_EMAIL_REGEX.match(email).nil?
    end

    def site?
      !URI.regexp.match(site).nil?
    end

    def send_thank_you_mail
      Worker::Mailer::GetReportThanks.perform_async(user.id, business.id)
    end

    # def generate_report
    #   Worker::Report::Generator.perform_async(user.id, business.id)
    # end

    def find_or_create_user
      UserFactory.new.find_or_create(email: email, subscription: subscription)
    end
  end
end