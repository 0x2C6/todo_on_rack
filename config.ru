require File.expand_path("./config/application.rb", File.dirname(__FILE__))

run Application::Boot.new
use Rack::Session::Cookie, :secret => "secret"
