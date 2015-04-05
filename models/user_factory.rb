class UserFactory

  attr_reader :args
  def find_or_create(*args)
    @args = args
    ensure_email
    find_or_create_user
    update_user
    user
  end

  attr_reader :user

  private

  def find_or_create_user
    @user = User.find_or_create(email)
  end

  def update_user
    user.update(subscription) if subscription?
  end

  def ensure_email
    raise NoEmailError unless email?
  end

  def email
    select_arg(:email)
  end

  def email?
    !email.empty?
  end

  def subscription
    select_arg(:subscription)
  end

  def subscription?
    value = subscription.fetch(:subscription) { 0 }
    value == 1
  end

  def select_arg(key)
    args[0].select { |k,v| k == key }
  end

  class NoEmailError < StandardError
    def message
      'need an email to find the user'
    end
  end
end