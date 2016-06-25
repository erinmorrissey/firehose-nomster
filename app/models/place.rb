class Place < ActiveRecord::Base
  # belongs_to means links_to another table (each Place links_to another user)
  belongs_to :user
  # has_many means links_from another table (each Place has a link from a comment)
  # dependent destroy means the comments connected to a place will be 
  #    automatically destroyed with the place itself is removed
  has_many :comments, :dependent => :destroy
  has_many :photos
  
  geocoded_by :address
  after_validation :geocode
  
  validates :address, :description, presence: true
  validates :name, presence: true, length: { minimum: 3 }
end
