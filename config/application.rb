require "bundler"
Bundler.require(:default)
require File.expand_path("./database/query_generators.rb", File.dirname(__FILE__))
require File.expand_path("./database/model.rb", File.dirname(__FILE__))
require File.expand_path("./database/schema.rb", File.dirname(__FILE__))
require File.expand_path("../db/schema.rb", File.dirname(__FILE__))

class Application
end
