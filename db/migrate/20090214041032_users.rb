class Users < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :hash
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
    
  end

  def self.down
    drop_table :users
  end
end
