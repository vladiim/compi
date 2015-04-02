class Business < Sequel::Model
  include SequelBeforeValidation

  many_to_many :users, join_table: :interests
end