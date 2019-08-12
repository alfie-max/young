class Advert < ApplicationRecord
    
  mount_uploader :image, ImageUploader
  
  enum status: { low: 0, medium: 1, high: 2, veryhigh:3 }
  
end