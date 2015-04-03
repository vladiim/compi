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
      @user     = create_user
      @business = user.add_business(url: site)
      send_thank_you_mail
      generate_report
    end

    def message
      Copy::Report.thank_you_page(email, site)
    end

    private

    def send_thank_you_mail
      Worker::Mailer::GetReportThanks.perform_async(user.id, business.id)
    end

    def generate_report
      Worker::Report::Generator.perform_async(user.id, business.id)
    end

    def create_user
      User.create(email: email, subscription: subscription)
    end
  end
end