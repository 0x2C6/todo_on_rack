require File.expand_path("../../config/database.rb", File.dirname(__FILE__))

class User < Database::Model
  has_many :todos
  has_secure_password
end
