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
      session["id"] = User.find_by(email: user.email).id #TODO buna ehtiyac qalmasin save id li object qaytarsin current_user
      redirect_to "/"
    end
  end

  def edit
    return redirect_to "/" unless logged_id?
    pp "salam"
    @user = User.find_by(id: session["id"])
    pp @user
    render view: "users/edit"
  end

  def update
    return redirect_to "/" unless logged_id?
    user = User.find_by(id: session["id"])
    redirect_to "/" if user.update_attributes(
      email: params("user[email]"),
      password: BCrypt::Password.create(params("user[password]")),
      first_name: params("user[first_name]"),
      last_name: params("user[last_name]"),
    )
  end
end
