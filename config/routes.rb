Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      resources :sessions
      resources :registrations
      resources :doctors
      resources :hospitals
      resources :schedules
      resources :bookings
    end
  end
end
