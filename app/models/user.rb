require File.expand_path("../../config/database.rb", File.dirname(__FILE__))

class User < Database::Model
  include BCrypt
  attr_accessor :id, :email, :first_name, :last_name, :password

  has_many :todos

  def initialize(data = {})
    @id = data[:id]
    @email = data[:email]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @password = data[:password]
  end

  def save
    @password = Password.create(@password)
    super
  end

  def valid_password?(password)
    Password.new(@password) == password
  end

  def self.result(hash)
    User.new(
      id: hash["id"],
      email: hash["email"],
      password: hash["password"],
      first_name: hash["first_name"],
      last_name: hash["last_name"],
    )
  end
end
