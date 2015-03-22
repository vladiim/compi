module Report
  class Form
    attr_reader :email, :site
    def initialize(email, site)
      @email = email
      @site  = site
    end

    def generate_report
      
    end

    def message
      Copy::Report.thank_you_page(email, site)
    end
  end
end