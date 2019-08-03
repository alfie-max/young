json.extract! advert, :id, :title, :image, :url, :desc, :created_at, :updated_at
json.url advert_url(advert, format: :json)
