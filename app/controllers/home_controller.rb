require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class HomeController < Application::Controller
  def index
    render view: "home/index"
  end
end
