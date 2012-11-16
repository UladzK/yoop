class AddAuthorsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :authors, :string
  end
end
