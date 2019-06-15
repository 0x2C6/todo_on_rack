require "bundler"
Bundler.require(:default)
require "erb"
require File.expand_path("./database/query_generators.rb", File.dirname(__FILE__))
require File.expand_path("./database/model.rb", File.dirname(__FILE__))
require File.expand_path("./database/schema.rb", File.dirname(__FILE__))
require File.expand_path("../db/schema.rb", File.dirname(__FILE__))
require File.expand_path("./application/router.rb", File.dirname(__FILE__))
require File.expand_path("./application/controller.rb", File.dirname(__FILE__))
require_all File.expand_path("../app/controllers", File.dirname(__FILE__))
require File.expand_path("./application/boot.rb", File.dirname(__FILE__))

module Application
end
