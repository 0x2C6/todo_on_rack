require File.expand_path("./application.rb", File.dirname(__FILE__))

class Routes < Application::Router
  get path: "/", to: "users#index"
  get path: "/test", to: "users#index"
end
