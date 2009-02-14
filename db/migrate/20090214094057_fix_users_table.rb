class FixUsersTable < ActiveRecord::Migration
  def self.up
    remove_column(:users, :hash)
    add_column(:users, :name, :string)
  end

  def self.down
  
  end

end
