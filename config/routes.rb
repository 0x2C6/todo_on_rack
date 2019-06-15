require File.expand_path("./application.rb", File.dirname(__FILE__))

class Routes < Application::Router
  get path: "/", to: "home#index"
  get path: "/users", to: "users#index"
end
