class AddUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :int
  end
end
