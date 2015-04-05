Sequel.migration do
  up do
    if Padrino.env == :production
      add_column :users, :created_at, DateTime, null: false
    end
  end
end