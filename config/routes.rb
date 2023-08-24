Rails.application.routes.draw do
  # Configuration de la route d'admin avec  Rails admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #Configuration de l'authentification avec devise pour users
  devise_for :users
  #Routes personnalisées pour l'utilisateur et l'admin invités
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest', as: :guest_sign_in
    post 'users/admin_guest_sign_in', to: 'users/sessions#new_admin_guest', as: :admin_guest_sign_in
  end
  #Configuration de la route pour active mailer
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :categories
  resources :users, except: [ :new ]
  resources :favorites, only: [:create, :destroy]
  resources :articles
  #Route personnalisé du controller articles pour l'action user_articles
  get 'users/:user_id/articles', to: 'articles#user_articles', as: :user_articles
  
end