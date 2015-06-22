require "active_support"
require "active_support/inflector"

module DatabaseClassMethods
  
  def all
    table_name = self.to_s.tableize
    results = DATABASE.execute("SELECT * FROM #{table_name}")
    store_results = []
    results.each do |hash|
      store_results << self.new(hash)
    end
    return store_results
  end
  
  def find(options = {})
    table_name = self.class.to_s.tableize
    results = DATABASE.execute("SELECT * FROM #{table_name} WHERE id = #{@id};").first
    self.new(results)
  end
  
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