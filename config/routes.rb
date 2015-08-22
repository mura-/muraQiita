Rails.application.routes.draw do
  resource :user
  get 'login' => 'sessions#new', as: :login
  resource :session, only: [ :create, :destroy ]
  resources :tips
  get 'mine' => 'tips#mine', as: :mine

  root 'tops#index'
end
