class Artist < ActiveRecord::Base
  attr_accessible :genre, :name
  has_and_belongs_to_many :tracks, :join_table => 'artists_tracks'
end
