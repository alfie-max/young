json.extract! post, :id, :user_id, :title, :body, :category_id, :image, :other_image, :author, :created_at, :updated_at
json.url post_url(post, format: :json)
