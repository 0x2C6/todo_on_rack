require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class SessionsController < Application::Controller
  def new
    user = User.find_by(email: "farhad9801@gmail.com")
    pp user["first_name"]
    render view: "sessions/new"
  end

  def create
    user = User.find_by(email: "email")
    # user.email = params["user[email]"]
    # user.password = params["user[password]"]

    # redirect_to "/login" if user.save
  end
end
