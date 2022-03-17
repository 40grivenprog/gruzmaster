Rails.application.routes.draw do
  devise_for :users,
  controllers: {
      sessions: 'users/sessions', # curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/users/sign_in
      registrations: 'users/registrations' # curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "email": "test@example.com", "password": "12345678" } }' http://localhost:3000/users
  }
  get '/member-data', to: 'members#index'
  resources :companies
end
