require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class HomeController < Application::Controller
  def index
    return redirect_to "/sessions/new" unless logged_id?
    @user = User.find_by(id: session["id"])
    # @user.todos

    render view: "home/index"
  end
end
