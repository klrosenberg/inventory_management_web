require "active_support"
require "active_support/inflector"

module DatabaseClassMethods
  
  # List and store all results from a specific table
  #
  # Returns results as an Array.
  def all
    table_name = self.to_s.tableize
    results = DATABASE.execute("SELECT * FROM #{table_name}")
    store_results = []
    results.each do |hash|
      store_results << self.new(hash)
    end
    return store_results
  end
  
  # Find a specific row from id.
  #
  # Returns new instance of the class.
  def find(options = {})
    table_name = self.class.to_s.tableize
    results = DATABASE.execute("SELECT * FROM #{table_name} WHERE id = #{id};").first
    self.new(results)
  end
  
  # Add to a table.
  # 
  # options = {} - to be filled with key value pairs 
  #
  # Returns a new instance of the class and adds to database.
  def add(options = {})
    columns = options.keys
    values = options.values
    columns_for_sql = columns.join(", ")
    individual_values_for_sql = []
    values.each do |value|
      if value.is_a?(String)
        individual_values_for_sql << "'#{value}'"
      else
        individual_values_for_sql << value
      end
    end
    values_for_sql = individual_values_for_sql.join(", ")
    table = self.to_s.pluralize.underscore
    DATABASE.execute("INSERT INTO #{table} (#{columns_for_sql}) VALUES (#{values_for_sql});")
    id = DATABASE.last_insert_row_id
    options["id"] = id
    self.new(options)
  end
  
  # Selects all rows of a table that share the same value of a specific column.
  #
  # column_name - String
  # id - Integer
  #
  # Returns an Array of results.
  def where(column_name, id)
     table_name = self.to_s.pluralize.underscore
     column_name = 
     results = DATABASE.execute("SELECT * FROM #{table_name} WHERE #{column_name} = #{id};")
     results_as_objects = []
     results.each do |result_hash|
       results_as_objects << self.new(result_hash)
     end
     return results_as_objects
   end
end