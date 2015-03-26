# class User < Sequel::Model
class User
  attr_reader :email, :table
  def initialize(email)
    @email = email
    @table = Sequel::Model.db[:users]
  end

  def save
    table.insert(email: email)
    # create(email: email)
  end
end