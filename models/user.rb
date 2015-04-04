class User < Sequel::Model
  include SequelBeforeValidation

  VALID_EMAIL_REGEX  = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  PRE_EMAIL_AT_REGEX = /^[^\@]*/

  many_to_many :businesses, join_table: :interests

  def validate
    super
    errors.add(:email, "#{ email } isn't an email") unless email_valid?
  end

  def name
    email.match(PRE_EMAIL_AT_REGEX)[0].capitalize if email
  end

  private

  def email_valid?
    return true if email.nil?
    VALID_EMAIL_REGEX.match(email)
  end
end