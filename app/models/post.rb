class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  mount_uploader :image, ImageUploader
  #mount_uploader :other_image, Other_imageUploader
end
