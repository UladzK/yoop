class AddIsadminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :isadmin, :integer
  end
end
