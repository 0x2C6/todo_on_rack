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
      return @@params[param].first if @@params[param].kind_of? Array
      @@params[param]
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
          .find do |route|
          if route[:param]
            @@params[route[:param]] = request.path_info.reverse.match("/").pre_match.reverse

            route[:path] == request.path_info.reverse.match("/").post_match.reverse
          else
            route[:path] == request.path_info
          end
        end

        if route.nil?
          file_path = File.expand_path("../../public/#{request.path_info}", File.dirname(__FILE__))

          if File.exist? file_path
            file = File.read(file_path)
          else
            file = File.read(File.expand_path("../../public/404.html", File.dirname(__FILE__)))
          end

          return [200, {}, [file]]
        end

        Object.const_get("#{route[:controller].capitalize}Controller").new.send(route[:action].to_sym)
      end
    end
  end
end
