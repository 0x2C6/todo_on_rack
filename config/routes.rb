require File.expand_path("./application.rb", File.dirname(__FILE__))

class Routes < Application::Router
  get path: "/", to: "home#index"
  get path: '/login', to: 'sessions#new'
  post path: '/sessions/create', to: 'sessions#create'
  get path: "/users", to: "users#index"
end
