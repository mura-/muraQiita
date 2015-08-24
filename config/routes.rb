Rails.application.routes.draw do
  root 'tops#index'

  resource :user, except:[ :destroy ] do
    resources :stocks, only: [ :index, :create, :destroy ]
  end

  resource :session, only: [ :create, :destroy ]
  get 'logout' => 'sessions#destroy', :as => :logout
  get '/auth/:provider/callback', :to => 'sessions#callback'
  post '/auth/:provider/callback', :to => 'sessions#callback'

  resources :tips do
    resources :comments, only: [ :create ]
  end
  get 'mine' => 'tips#mine', as: :mine

end
