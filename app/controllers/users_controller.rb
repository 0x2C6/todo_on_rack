require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class UsersController < Application::Controller
  def index
    puts "salamlar"
    render view: "<h1>Hello wordls</h1>"
  end
end
