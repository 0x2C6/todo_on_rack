require File.expand_path("./application.rb", File.dirname(__FILE__))

module Database
  extend QueryGenerators
  $db = SQLite3::Database.new "todo_on_rack.db" # TOP_LEVEL_BINDING ELIYIM ? :D
  tables = $db.execute("SELECT name FROM sqlite_master WHERE type='table'").flatten

  define_singleton_method :create_table do |base, columns|
    return if tables.include? base.downcase

    $db.execute <<-SQL
      create table if not exists #{base.downcase} (
        #{columns_with_type(columns)}
      );
    SQL
    puts "#{base} created"
  end
end
