class ProductCategory
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_accessor :id, :category_name
  
  def initialize(options = {})
    @id = options['id']
    @category_name = options['category_name']
  end
  
  # Finds row in database associated with id.
  #
  # Creates a new object with values from all columns.
  #
  # Returns new object.
  def self.find_by(id)
    @id = id
   results = DATABASE.execute("SELECT * FROM product_categories WHERE id = #{@id};").first
   name = results['category_name']
   new_object = ProductCategory.new(id, name)
   return new_object
 end

  # List rows of floral_department_products where id is the same.
  #
  # Return Hash of floral_department_products that share the same category_id.
  def list_by
    results = DATABASE.execute("SELECT * FROM floral_department_products WHERE category_id = #{@id};")
    results_as_array = []
    results.each do |object|
      results_as_array << FloralDepartmentProduct.new(object['id'], object['product'], object['quantity'], object['cost'])
    end
    return results_as_array
  end
  
  # Add a new category to the Categories table.
  #
  # category_name = String
  #
  # Add a new row to the table, assigning an id to the category_name.
  # def self.add(category_name)
  #   DATABASE.execute("INSERT INTO product_categories (category_name) VALUES ('#{category_name}');")
  #   id = DATABASE.last_insert_row_id
  #   new_object = ProductCategory.new(id, category_name)
  #   return new_object
  # end
  
  # Sync Ruby object updates to the database.
  #
  # Returns Boolean.
  def save
    if DATABASE.execute("UPDATE prodcut_categories SET category_name = '#{category_name}' WHERE id = #{@id};")
      return true
    else
      return false
    end
  end
  
  # Check id of category name.
  #
  # category_name = String
  #
  # Return id associated with that name.
  def self.check_id(category_name)
   result = DATABASE.execute("SELECT id FROM product_categories WHERE category_name = '#{category_name}';")
   result.first['id']
  end
  
  # Delete category from table.
  #
  # Delete entire row from product_categories table based on id.
  # def delete
 #    DATABASE.execute("DELETE FROM product_categories WHERE id = #{@id};")
 #  end
end
