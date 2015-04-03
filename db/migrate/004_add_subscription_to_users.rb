Sequel.migration do
  up do
    add_column :users, :subscription, Integer, default: 0

    alter_table(:users) do
      add_unique_constraint [:email]
    end
  end

  down do
    drop_column :users, :subscription
  end
end