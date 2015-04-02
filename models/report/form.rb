module Report
  class Form
    attr_reader :email, :site
    def initialize(email, site)
      @email = email
      @site  = site
    end

    def process
      user = create_user
      user.add_business(url: site)
      send_thank_you_mail
      generate_report
    end

    def message
      Copy::Report.thank_you_page(email, site)
    end

    private

    def send_thank_you_mail
      # should be doing this with ids only!
      Worker::Mailer::GetReportThanks.perform_async(email, site)
    end

    def generate_report
      # should be doing this with ids only!
      Worker::Report::Generator.perform_async(email, site)
    end

    def create_user
      User.create(email: email)
    end
  end
end