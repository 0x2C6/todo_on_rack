require File.expand_path("../../config/database.rb", File.dirname(__FILE__))

class Todo < Database::Model
  attr_accessor :title, :due_to, :priority, :status, :user_id

  def initialize(data = {})
    @title = data[:title]
    @due_to = data[:due_to]
    @priority = data[:priority]
    @priority = data[:priority]
    @user_id = data[:user]
  end
end
