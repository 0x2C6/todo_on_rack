require File.expand_path("../../config/database.rb", File.dirname(__FILE__))

class User < Database::Model
  include BCrypt
  attributes = [:email, :first_name, :last_name, :password]
  attr_accessor *attributes

  def initialize(data = {})
    @email = data[:email]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @password = Password.create(data[:password])
  end
end

a = User.new(
  email: "farhaddeeddwedewyvadzli2@gmail.com",
  first_name: "dadas",
  password: "123456",
  last_name: "eyvazli",
)
a.save
