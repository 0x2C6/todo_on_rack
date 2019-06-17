require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class HomeController < Application::Controller
  def index
    return redirect_to "/sessions/new" unless logged_id?
    @todos = Todo.where({ user_id: session["id"] }, order: { id: :asc }, not: { status: :done })
    render view: "home/index" #, locals: { user: @user }
  end
end
