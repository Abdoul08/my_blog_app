Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :categories
  resources :users, except: [ :new ]
  resources :favorites, only: [:create, :destroy]
  resources :articles
  get 'users/:user_id/articles', to: 'articles#user_articles', as: :user_articles
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
