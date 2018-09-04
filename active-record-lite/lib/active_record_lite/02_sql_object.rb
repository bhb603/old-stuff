require_relative 'db_connection'
require_relative '01_mass_object'
require 'active_support/inflector'
require 'debugger'

class MassObject
  def self.parse_all(results)
    p self
    results.map do |result|
      self.new(result)
    end
  end
end

class SQLObject < MassObject
  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.underscore.pluralize
  end

  def self.all
    query = "SELECT #{self.table_name}.* FROM #{self.table_name};"
    results = DBConnection.execute(query)
    self.parse_all(results)
  end

  def self.find(id)
    query = "SELECT #{self.table_name}.* FROM #{self.table_name} WHERE id = ?"
    results = DBConnection.execute(query, id)
    self.parse_all(results).first
  end

  def insert

    col_names = self.class.attributes.reject {|attr| attr == :id}
    question_marks = (["?"]*col_names.length).join(", ")
    sql_command = <<-SQL
    INSERT INTO #{self.class.table_name} (#{col_names.join(", ")})
    VALUES (#{question_marks})
    SQL

    DBConnection.execute(sql_command, attribute_valuess)
    self.id = DBConnection.last_insert_row_id
  end

  def save
    # ...
  end

  def update
    # col_names = self.class.attributes.reject {|attr| attr == :id}
    #
    # cols = []
    # col_names.each { |col_name| cols << "#{col_name} ?" }
    # cols.join(", ")
    #
    #
    # sql_command = <<-SQL
    # UPDATE #{self.class.table_name}
    # SET #{cols}
    # WHERE id = #{self.id}
    # SQL


  end

  def attribute_values
    self.class.attributes.map { |attr| self.send(attr) }.compact
    # vals.reject {|val| val.nil?}
  end

  def attribute_values_sans_id
    self.class.attributes.map do |attribute|
      next if attribute.to_sym == :id
      self.send(attribute)

    end
  end

end
