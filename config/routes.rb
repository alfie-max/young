Rails.application.routes.draw do
  resources :categories
  devise_for :users
  resources :posts
  get '/gallery', to: 'posts#gallery', as: :gallery
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
end
