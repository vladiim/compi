Sequel.migration do
  change do
    create_table :businesses do
      primary_key :id
      String :url
      DateTime :created_at, null: false
    end
  end
end