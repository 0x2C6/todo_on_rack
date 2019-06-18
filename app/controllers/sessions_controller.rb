require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class SessionsController < Application::Controller
  using RefineHash

  def new
    return redirect_to "/" if logged_id?
    render view: "sessions/new"
  end

  def create
    return redirect_to "/" if logged_id?
    user = User.find_by(email: params("sessions[email]"))
    if user && user.valid_password?(params("sessions[password]"))
      session["id"] = user.id
      return redirect_to "/"
    end
    redirect_to "/sessions/new"
  end
end
