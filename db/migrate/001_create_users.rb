Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      String :email
      DateTime :created_at, null: false
    end
  end
end