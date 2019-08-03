class Advert < ApplicationRecord
    
  mount_uploader :image, ImageUploader
  
end
