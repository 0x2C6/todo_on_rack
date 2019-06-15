module Application
  class Controller
    def render(option = {})
      option[:status] = 200
      return [option[:status], { "Content-Type" => "text/html" }, [option[:view]]]
    end

    class << self
      def request_handler(env)
        request = Rack::Request.new(env)

        route = Router.class_variable_get("@@#{request.request_method.downcase}_routes")
          .find { |route| route[:path] == request.path_info }

        Object.const_get("#{route[:controller].capitalize}Controller").new.send(route[:action].to_sym)
      end

      def controller_response
        puts "salam"
      end
    end
  end
end
