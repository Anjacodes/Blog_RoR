Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
       resources :comments, only: [:create, :destroy]
       resources :likes, only: [:create]
    end
  end

  root "users#index"

  get '/api/users/:id/posts', to: 'api#posts_index'
  get '/api/users/:id/posts/:id', to: 'api#list_comments'
  post '/api/users/:id/posts/:id', to: 'api#create_comment'
end
