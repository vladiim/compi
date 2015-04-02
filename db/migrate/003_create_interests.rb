Sequel.migration do
  change do
    create_table :interests do
      primary_key :id
      Integer :user_id, null: false
      Integer :business_id, null: false
    end
  end
end