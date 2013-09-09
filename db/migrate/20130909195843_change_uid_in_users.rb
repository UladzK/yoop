class ChangeUidInUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :uid, :long
  end

  def self.down
    change_column :users, :uid, :int
  end
end
