class Artist < ActiveRecord::Base
  attr_accessible :genre, :name, :artist_ids
  has_and_belongs_to_many :tracks, :join_table => 'artists_tracks'

  validates_presence_of :name, :on => :create, :message => "cannot be blank"

  #validates_presence_of :genre, :on => :create, :message => "cannot be blank"
  validates :genre, :format => { :with => /\A[a-zA-Z]+\z/,
                            :message => "only letters allowed" }

	def self.search(search)
		if search
      find(:all, :conditions => ['name LIKE?', "%#{search}%"])
	  else
      find(:all)
    end
  end
end
