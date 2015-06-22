class Location
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_accessor :id, :location_name 
  
  def initialize(options = {})
    @id = options['id']
    @location_name = options['location_name']
  end

  # Finds row in database associated with id.
  #
  # Creates a new object with values from all columns.
  #
  # Returns new object.
  def self.find_by(id)
    @id = id
   results = DATABASE.execute("SELECT * FROM product_categories WHERE id = #{@id};").first
   new_object = Location.new(id, results['location_name'])
   return new_object
 end
  
  # List all rows of floral_department_products that share the same location_id.
  #
  # Return Hash of floral_department_products that share the same location_id.
  def list_by
    results = DATABASE.execute("SELECT * FROM floral_department_products WHERE location_id = #{@id};")
    results_as_array = []
    results.each do |object|
      results_as_array << FloralDepartmentProduct.new(object['id'], object['product'], object['quantity'], object['cost'])
    end
    return results_as_array
  end

  # Add a new location to the Locations table.
  #
  # location_name = String
  #
  # Add a new row to the table, assigning an id to the location_name.
  # def self.add(location_name)
 #    DATABASE.execute("INSERT INTO locations (location_name) VALUES ('#{location_name}');")
 #    id = DATABASE.last_insert_row_id
 #    new_object = Location.new(id, location_name)
 #    return new_object
 #  end
  
  # Sync Ruby object updates to the database.
  #
  # Returns Boolean.
  def save
    if DATABASE.execute("UPDATE locations SET location_name = '#{location_name}' WHERE id = #{@id};")
      return true
    else
      return false
    end
  end
    
  # Check id of category name.
  #
  # location_name = String
  #
  # Return id associated with that name.  
  def self.check_id(location_name)
   result = DATABASE.execute("SELECT id FROM locations WHERE location_name = '#{location_name}';")
   result.first['id']
  end
  
  # Delete location from table.
  #
  # Delete entire row from locations table based on id.
  # def delete
 #    DATABASE.execute("DELETE FROM locations WHERE id = #{@id};")
 #  end
end
