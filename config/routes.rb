Yoop::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  root :to => 'artists#index'

  resources :tracks
  resources :artists
  resources :sessions
  resources :users
end