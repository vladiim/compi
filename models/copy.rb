module Copy
  module Report
    def self.thank_you_page(email, site)
      "Thanks. Your report for #{ site } will take a few minutes to generate. We'll send you an email to #{ email } when it's ready."
    end
  end
end