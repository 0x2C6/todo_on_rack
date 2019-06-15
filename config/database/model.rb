module Database
  class Model
    include Database::QueryGenerators

    def self.inherited(base)
      Database::create_table(base.name, Schema.models(base.name))
      base.include ModelInstanceMethods
      base.extend ModelClassMethods
    end

    module ModelInstanceMethods
      def save
        records = (Schema.models(self.class.name).keys.reject { |k| k == :id }.map do |iv|
          self.instance_variable_get("@#{iv.to_s}")
        end)

        $db.execute insert(self), records
      end
    end

    module ModelClassMethods
      def create(data = {})
        record = new(data)
        record.save
      end
    end
  end
end
