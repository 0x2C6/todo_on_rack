require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class SessionsController < Application::Controller
  def new
    render view: "sessions/new"
  end

  def create
    pp params("sessions[email]")
    redirect_to "/login"
  end
end
