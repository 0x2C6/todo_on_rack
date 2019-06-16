module Application
  class Controller
    @@params = {}

    def render(option = {})
      option[:status] = 200
      return [option[:status],
              { "Content-Type" => "text/html" },
              [view_renderer(option[:view], option[:locals])]]
    end

    def session
      @@session
    end

    def logged_id?
      return false unless @@session["id"]
      @@session["id"]
    end

    def redirect_to(path)
      return [302, { "Location" => path }, []]
    end

    def params(param)
      @@params[param].first
    end

    def template_binding(locals = nil)
      # locals.each do |k, v|
      #   # instance_variable_set "@#{k}", v
      # end if locals
      binding
    end

    def view_renderer(view, locals)
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
               )).result(template_binding(locals))
             })
    end

    class << self
      def request_handler(env)
        request = Rack::Request.new(env)
        @@session = env["rack.session"]

        class_variable_set("@@params", CGI.parse(request.body.read))
        route = Router.class_variable_get("@@#{request.request_method.downcase}_routes")
          .find { |route| route[:path] == request.path_info }

        Object.const_get("#{route[:controller].capitalize}Controller").new.send(route[:action].to_sym)
      end
    end
  end
end
