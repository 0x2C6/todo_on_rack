require File.expand_path("../../config/database.rb", File.dirname(__FILE__))

class Todo < Database::Model
  attributes = [:title, :due_to, :priority, :status, :user_id]
  attr_accessor *attributes

  def initialize(data = {})
    @title = data[:title]
    @due_to = data[:due_to]
    @priority = data[:priority]
    @priority = data[:priority]
    @user_id = data[:user]
  end
end

# puts User

# a = Todo.new
# a.title = "test"
# a.user_id = 1
# a.save
