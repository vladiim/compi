class Email
  attr_reader :api, :template, :from_email, :from_name
  def initialize(template)
    @api        = EMAIL_API
    @template   = template
    @from_email = 'compivlad@gmail.com'
    @from_name  = 'Vlad at Compi'
  end

  def deliver
    begin
      api.messages.send(message)
    rescue => e
      "An email send error occurred: #{e.message}\n The email message: #{message}"
    end
  end

  def message
   { 'important'      => false,
     'subject'        => template.subject_line,
     'from_email'     => from_email,
     'headers'        => { 'Reply-To' => from_email},
     'from_name'      => from_name,
     'merge_language' =>'mailchimp',
     'recipient_metadata' =>
        [{ 'values' => { 'user_id' => template.user.id},
                         'rcpt'    => template.user.email}],
     'to' =>
        [{'name'    => template.user.name,
            'type'  =>'to',
            'email' => template.user.email}],
     'html' => template.html_content,
     'text' => template.text_content}
  end
end