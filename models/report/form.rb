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

    def message
      Copy::Report.thank_you_page(email, site)
    end

    private

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