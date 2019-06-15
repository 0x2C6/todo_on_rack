module Application
  class Controller
    def render(option = {})
      option[:status] = 200
      return [option[:status], { "Content-Type" => "text/html" }, [view_renderer(option[:view])]]
    end

    def template_binding
      binding
    end

    def view_renderer(view)
      return ERB.new(File.read(
               File.expand_path(
                 "../../app/views/layouts/application.html.erb",
                 File.dirname(
                   __FILE__
                 )
               )
             )).result(template_binding {
               ERB.new(File.read(
                 File.expand_path(
                   "../../app/views/#{view}.html.erb",
                   File.dirname(
                     __FILE__
                   )
                 )
               )).result
             })
    end

    class << self
      def request_handler(env)
        request = Rack::Request.new(env)

        route = Router.class_variable_get("@@#{request.request_method.downcase}_routes")
          .find { |route| route[:path] == request.path_info }

        Object.const_get("#{route[:controller].capitalize}Controller").new.send(route[:action].to_sym)
      end
    end
  end
end
