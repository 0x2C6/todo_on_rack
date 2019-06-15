module Application
  class Router
    @@methods = [:get, :post]
    @@get_routes = []
    @@post_routes = []

    class << self
      @@methods.each do |method_name|
        define_method method_name do |route|
          class_variable_get("@@#{__method__}_routes") << {
            method: __method__.to_s,
            path: route[:path],
            controller: route[:to].match("#").pre_match,
            action: route[:to].match("#").post_match,
          }
        end
      end

      def routes
        @@methods.map { |method| class_variable_get("@@#{method}_routes") }
      end
    end
  end
end
