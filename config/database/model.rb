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
      rescue
        return false
      end
    end

    module ModelClassMethods
      def create(data = {})
        record = new(data)
        record.save
      end

      def find_by(columns = {})
        result = $db.execute2(find(self.name, columns), columns.values)
        return nil if result.size == 1
        result.first.zip(result.last).to_h
      end
    end
  end
end
