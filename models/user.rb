class User
  attr_reader :email, :db
  def initialize(email)
    @email = email
    @db    = Sequel::Model.db[:users]
  end

  def save
    db.insert(email: email)
  end
end