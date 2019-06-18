module Database
  class Model
    include Database::QueryGenerators

    def self.inherited(base)
      Database::create_table(base.name, Schema.models(base.name))
      base.include ModelInstanceMethods
      base.extend ModelClassMethods

      base.class_eval do
        attr_accessor *Schema.models(base.name).keys

        def initialize(data = {})
          data.each do |k, v|
            instance_variable_set("@#{k.to_s}", v)
          end
        end

        def self.result(hash)
          return self.new(
            hash
          )
        end
      end
    end

    module ModelInstanceMethods
      def save
        records = (Schema.models(self.class.name).keys.reject { |k| k == :id }.map do |iv|
          self.instance_variable_get("@#{iv.to_s}")
        end)

        $db.execute insert(self), records
      rescue => e
        pp e
        return false
      end

      def destroy
        $db.execute delete(self), self.id
      rescue => e
        pp e
        false
      end

      def update_attributes(attributes)
        $db.execute update(self, attributes)
      rescue => e
        pp e
        false
      end
    end

    module ModelClassMethods
      include BCrypt

      def has_many(model)
        return Object.const_get(model.to_s.chop.capitalize).where(user_id: self.instance_variable_get("@id"))
      end

      def has_secure_password
        self.class_eval do
          def save
            @password = Password.create(@password)
            super
          end

          def valid_password?(password)
            Password.new(@password) == password
          end
        end
      end

      def create(data = {})
        record = new(data)
        record.save
      end

      def where(columns, opts = nil)
        results = $db.execute2(find(self.name, columns, opts), columns.values)
        data = []

        columns = results.shift
        results.each do |result|
          data << self.result(columns.zip(result).to_h)
        end

        return data
      end

      def find_by(columns = {})
        result = $db.execute2(find(self.name, columns), columns.values)
        result.first.zip(result.last).to_h
        return nil if result.size == 1
        self.result(result.first.zip(result.last).to_h)
      end
    end
  end
end
