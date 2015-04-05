Sequel.migration do
  up do
    add_column :users, :created_at, DateTime, null: false
  end

  down do
    drop_column :users, :created_at
  end
end