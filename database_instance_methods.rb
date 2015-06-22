require "active_support"
require "active_support/inflector"

module DatabaseInstanceMethods
  
  # Saves a specific instance to the database.
  #
  # Returns boolean.
  def save  
    if DATABASE.execute("UPDATE prodcut_categories SET category_name = '#{category_name}' WHERE id = #{@id};")
      return true
    else
      return false
    end
  end
    
  # Deletes an entry from the database.
  def delete
     table_name = self.class.to_s.pluralize.underscore
     DATABASE.execute("DELETE FROM #{table_name} WHERE id = #{@id};")
  end
end