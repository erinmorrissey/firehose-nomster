class Photo < ActiveRecord::Base
  # belongs_to means links_to another table (each Photo links_to another place)
  belongs_to :place
  mount_uploader :picture, PictureUploader
end
