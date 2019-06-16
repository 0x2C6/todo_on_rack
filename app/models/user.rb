require File.expand_path("../../config/database.rb", File.dirname(__FILE__))

class User < Database::Model
  include BCrypt
  attr_accessor :email, :first_name, :last_name, :password

  def initialize(data = {})
    @email = data[:email]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @password = Password.create(data[:password])
  end

  def password=(value)
    @password = Password.create(value)
  end
end
