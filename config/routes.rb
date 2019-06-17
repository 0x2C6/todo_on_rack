require File.expand_path("./application.rb", File.dirname(__FILE__))

class Routes < Application::Router
  get path: "/", to: "home#index"
  get path: "/sessions/new", to: "sessions#new"
  post path: "/sessions/create", to: "sessions#create"
  get path: "/users", to: "users#index"
  get path: "/users/new", to: "users#new"
  post path: "/users/create", to: "users#create"
  get path: "/todos/new", to: "todos#new"
  post path: "/todos/create", to: "todos#create"
  # post path: "/todos/delete/:id", to: "todos#delete"
  pp routes
end
