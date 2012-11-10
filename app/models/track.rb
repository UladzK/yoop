class Track < ActiveRecord::Base
  attr_accessible :title, :lyrics, :artist_ids
  has_and_belongs_to_many :artists, :join_table => 'artists_tracks'
end
