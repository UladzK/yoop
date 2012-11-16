class AddUrlToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :url, :string
  end
end
