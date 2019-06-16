require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class UsersController < Application::Controller
  def index
    return redirect_to "/sessions/new" unless logged_id?
    render view: "users/index"
  end

  def new
    return redirect_to "/" if logged_id?
    render view: "users/new"
  end

  def create
    return redirect_to "/" if logged_id?

    user = User.new
    user.email = params("user[email]")
    user.password = params("user[password]")
    user.first_name = params("user[first_name]")
    user.last_name = params("user[last_name]")

    if user.save
      session["id"] = User.find_by(email: user.email).id #TODO buna ehtiyac qalmasin save id li object qaytarsin
      redirect_to "/"
    end
  end
end
