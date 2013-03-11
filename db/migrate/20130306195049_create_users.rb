class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,  :null => false
      t.string :first_name
      t.string :last_name
      t.string :email,     :null => false
      t.string :password,  :null => false
      t.string :salt,      :null => false
      t.integer :role_id,  :null => false, :default => 2

      t.timestamps
    end
    add_index :users, :username, :name => "uq_username", :unique => true 
  end
end
