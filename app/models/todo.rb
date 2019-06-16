require File.expand_path("../../config/database.rb", File.dirname(__FILE__))

class Todo < Database::Model
  attr_accessor :id, :title, :due_to, :priority, :status, :user_id

  def initialize(data = {})
    @id = data[:id]
    @title = data[:title]
    @due_to = data[:due_to]
    @priority = data[:priority]
    @status = data[:status]
    @user_id = data[:user_id]
  end

  def self.result(hash)
    Todo.new(
      id: hash["id"],
      title: hash["title"],
      due_to: hash["due_to"],
      priority: hash["priority"],
      status: hash["status"],
      user_id: hash["user_id"],
    )
  end
end
