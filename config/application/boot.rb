require File.expand_path("../routes", File.dirname(__FILE__))

module Application
  class Boot
    def call(env)
      Controller.request_handler(env)
    end
  end
end
