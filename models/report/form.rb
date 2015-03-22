module Report
  class Form
    attr_reader :email, :site
    def initialize(email, site)
      @email = email
      @site  = site
    end

    def process
      create_user
      send_thank_you_mail
      generate_report
    end

    def message
      Copy::Report.thank_you_page(email, site)
    end

    private

    def send_thank_you_mail
      Worker::Mailer::GetReportThanks.perform_async(email, site)
    end

    def generate_report
      Worker::Report::Generator.perform_async(email, site)
    end

    def create_user
      User.new(email).save
    end
  end
end