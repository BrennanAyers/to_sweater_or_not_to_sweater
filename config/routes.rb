Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'

      get '/background', to: 'background#show'

      resources :users, only: [:create]
      post '/sessions', to: 'sessions#create'
    end
  end
end
