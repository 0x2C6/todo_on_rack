require File.expand_path("./application.rb", File.dirname(__FILE__))

class Routes < Application::Router
  get path: "/", to: "home#index"
  get path: "/sessions/new", to: "sessions#new"
  post path: "/sessions/create", to: "sessions#create"
  post path: "/sessions/logout", to: "sessions#destroy"
  get path: "/users", to: "users#index"
  get path: "/users/new", to: "users#new"
  post path: "/users/create", to: "users#create"
  get path: "/users/edit", to: "users#edit"
  post path: "/users/update", to: "users#update"
  get path: "/todos", to: "todos#index"
  get path: "/todos/new", to: "todos#new"
  post path: "/todos/create", to: "todos#create"
  get path: "/todos/edit/:id", to: "todos#edit"
  post path: "/todos/update/:id", to: "todos#update"
  post path: "/todos/delete/:id", to: "todos#delete"
end
