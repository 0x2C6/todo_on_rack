require File.expand_path("../routes", File.dirname(__FILE__))

module Application
  class Boot
    def call(env)
     pp Controller.request_handler(env)
      # [200, { "Content-Type" => "text/html" }, ["hello world"]]
    end
  end
end
