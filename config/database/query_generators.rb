module Database
  module QueryGenerators
    def self.included(base)
      base.extend ClassMethods
    end

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
            query << " #{value ? "REFERENCES #{value}(#{name})" : ""}"
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

    module ClassMethods
      def find(table, columns, opts = nil)
        column_names = ""

        table = table.downcase
        columns.each do |k, v|
          column_names << " #{table}.#{k.to_s} = ? AND "
        end
        column_names = column_names.reverse.sub("DNA", "").reverse
        query = "SELECT * FROM #{table} WHERE #{column_names}"
        if opts
          opts[:not].each do |k, v|
            query << " AND NOT #{k.to_s} = '#{v}'"
          end if opts[:not]
          if opts[:order]
            query << "ORDER BY "
            opts[:order].each do |k, v|
              query << "#{k.to_s} #{v.upcase}"
            end
          end
        end

        pp query
        return query
      end
    end
  end
end
