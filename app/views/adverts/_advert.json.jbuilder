json.extract! advert, :id, :title, :image, :url, :status, :desc, :created_at, :updated_at
json.url advert_url(advert, format: :json)
