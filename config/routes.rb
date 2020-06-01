Rails.application.routes.draw do
  devise_for :users
  get 'articles/index'

  resources :articles do
    resources :comments
  end

  # resources :users do
  #   resources :comments
  # end

  # resources :categories do
  #   resources :articles
  # ends

get '/categories/:category_handle/articles', to: 'articles#index', as: :category_articles


  root 'articles#index'
end
