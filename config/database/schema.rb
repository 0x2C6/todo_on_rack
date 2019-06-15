module Database
  class Schema
    models = {}
    define_singleton_method :models do |model_name|
      models[model_name]
    end

    define_singleton_method :schema do |model, columns|
      models[model] = columns
    end
  end
end
