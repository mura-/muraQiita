Rails.application.routes.draw do
  resource :user do
    resources :stocks
  end
  get 'login' => 'sessions#new', as: :login
  resource :session, only: [ :create, :destroy ]
  resources :tips do
    resources :comments
  end

  get 'mine' => 'tips#mine', as: :mine

  root 'tops#index'

  get '/auth/:provider/callback', :to => 'sessions#callback'
  post '/auth/:provider/callback', :to => 'sessions#callback'
  get '/logout' => 'sessions#destroy', :as => :logout
end
