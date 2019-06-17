require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class TodosController < Application::Controller
  def index
    @todos = Todo.where({ user_id: session["id"] })
    render view: "todos/index"
  end

  def new
    # pp params("id")
  end

  def create
  end

  def delete
  end

  def update
  end

  def edit
  end
end
