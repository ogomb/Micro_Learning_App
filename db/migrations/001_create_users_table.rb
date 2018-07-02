Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      String :email, :unique => true, :length => 126, :null => false
      String :name, :unique => true, :length => 32, :null => false
      String :password, :length => 32, :null => false
    end
  end
end