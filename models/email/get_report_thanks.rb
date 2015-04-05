module EmailTemplate
  class GetReportThanks

    delegate :deliver, to: :mailer

    attr_reader :user, :business, :subject_line, :mailer
    def initialize(user_id, business_id)
      @user         = User.find(id: user_id.to_i)
      @business     = Business.find(id: business_id.to_i)
      @subject_line = 'Your Competitive Intelligence Report'
      @mailer       = Email.new(self)
    end

    def html_content
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
        .render(content)
    end

    def text_content
      content
    end

    private

    def content
      """
        Hi and thanks for requesting a compi report for #{ @business.url }.
        I'm currently building out the first version of the reporting tool. Once it's complete I'll email you the report.
        In the meantime please feel free to get in touch if you have any questions or specific requests.
        Cheers,
        Vlad
      """
    end
  end
end