require File.expand_path("../../config/application.rb", File.dirname(__FILE__))

class TodosController < Application::Controller
  def index
    return redirect_to "/sessions/new" unless logged_id?
    @todos = Todo.where({ user_id: session["id"] }, order: { title: :asc })
    render view: "todos/index"
  end

  def new
    return redirect_to "/sessions/new" unless logged_id?
    render view: "todos/new"
  end

  def create
    return redirect_to "/sessions/new" unless logged_id?
    Todo.create(
      title: params("todos[title]"),
      due_to: params("todos[due_to]"),
      status: params("todos[status]"),
      priority: params("todos[priority]"),
      user_id: session["id"],
    )
    redirect_to "/todos"
  end

  def delete
    return redirect_to "/sessions/new" unless logged_id?
    todo = Todo.find_by(id: params("id"))
    return redirect_to "/404" unless todo.user_id == session["id"]
    if todo.user_id == session["id"]
      redirect_to "/todos" if todo.destroy
    end
  end

  def update
    return redirect_to "/sessions/new" unless logged_id?
    todo = Todo.find_by(id: params("id"))
    return redirect_to "/404" unless todo.user_id == session["id"]
    redirect_to "/todos" if todo.update_attributes(
      title: params("todos[title]"),
      due_to: params("todos[due_to]"),
      status: params("todos[status]"),
      priority: params("todos[priority]"),
    )
  end

  def edit
    return redirect_to "/sessions/new" unless logged_id?
    @todo = Todo.find_by(id: params("id"))
    return redirect_to "/404" unless @todo.user_id == session["id"]
    render view: "todos/edit"
  end
end
