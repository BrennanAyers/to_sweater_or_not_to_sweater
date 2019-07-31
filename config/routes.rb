Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'
      get '/road_trip', to: 'road_trip#show'

      get '/background', to: 'background#show'

      resources :users, only: [:create]
      post '/sessions', to: 'sessions#create'
    end
  end
end
