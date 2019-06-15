module Database
  module QueryGenerators
    def columns_with_type(column)
      query = ""
      column.each do |name, options|
        query << " #{name.to_s}"
        options.each do |option, value|
          case option
          when :type
            query << " #{value.upcase}"
          when :null
            query << " #{value ? "" : "NOT NULL"}"
          when :primary_key
            query << " #{value ? "PRIMARY KEY" : ""}"
          when :unique
            query << " #{value ? "UNIQUE" : ""}"
          when :foreign_key
            query << " #{value ? ",FOREIGN KEY(#{name})" : ""}"
          when :reference
            query << " #{value ? "REFERENCES #{value.capitalize}(#{name})" : ""}"
          end
        end
        query << ","
      end
      return query.chop
    end

    def insert(table)
      fields = Schema.models(table.class.name).keys.reject { |k| k == :id }
      return "
      INSERT INTO #{table.class.to_s.downcase} (#{fields.join(",")})
      VALUES (#{(Array.new(fields.size) { "?" }).join(",")})
      "
    end
  end
end
