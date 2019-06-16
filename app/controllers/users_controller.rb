require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class UsersController < Application::Controller
  def index
    pp logged_id?
    return redirect_to "/sessions/new" unless logged_id?
    render view: "users/index"
  end

  def new
    render view: "users/new"
  end

  def create
    user = User.new
    user.email = params("user[email]")
    user.password = params("user[password]")
    user.first_name = params("user[first_name]")
    user.last_name = params("user[last_name]")

    redirect_to "/" if user.save
  end
end
