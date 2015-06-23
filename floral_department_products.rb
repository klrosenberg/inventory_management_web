class FloralDepartmentProduct
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_reader :id
  attr_accessor :product, :category_id, :cost, :location_id, :quantity
  
  def initialize(options = {})
    @id = options['id']
    @product = options['product']
    @category_id = options['category_id']
    @cost = options['cost']
    @location_id = options['location_id']
    @quantity = options['quantity']
  end

  # Find row in floral_department_products table associated with id.
  #
  # id = Integer of specific row
  #
  # Returns a new object storing all the information of that row.
 #  def self.find(id)
 #    @id = id
 #   results = DATABASE.execute("SELECT * FROM floral_department_products WHERE id = #{@id};").first
 #   new_object = FloralDepartmentProduct.new(id, results['product'], results['category_id'], results ['cost'], results['location_id'], results['quantity'])
 #   return new_object
 # end
   
  # List all rows of floral_department_products table.
  #
  # Return Hash of floral_department_products table.
  # def self.all_as_array
  #   results = self.all
  #   results_as_array = []
  #   results.each do |object|
  #     results_as_array << FloralDepartmentProduct.new(object['id'], object['product'], object['category_id'], object['cost'], object['location_id'], object['quantity'])
  #   end
  #   return results_as_array
  # end
    
  # Add a new product (row) to the floral_department_products table.
  #
  # product = String
  # category_id = Integer
  # cost = Integer
  # location_id = Integer (default set to 1)
  # quantity = Integer (default set to 0)
  # 
  # Returns new object of Floral Department Class and adds to database.
  # def self.add(product, category_id, cost, location_id = 1, quantity = 0)
  #   DATABASE.execute("INSERT INTO floral_department_products (product, category_id, cost, location_id, quantity) VALUES ('#{product}', '#{category_id}', '#{cost}', '#{location_id}', '#{quantity}');")
  #   id = DATABASE.last_insert_row_id
  #   new_object = FloralDepartmentProduct.new(id, product, category_id, cost, location_id, quantity)
  #   return new_object
  # end
  
  # Update product in database.
  #
  # Returns Boolean.
  def save
    if
      DATABASE.execute("UPDATE floral_department_products SET product = '#{@product}', category_id = #{@category_id}, cost = #{@cost}, location_id = #{@location_id}, quantity = #{@quantity}  WHERE id = #{@id};")
      return true
    else
      return false
    end
  end

  # Delete product from table.
  #
  # Delete an entire row from floral_department_products table based on id.
  # def delete
  #   DATABASE.execute("DELETE FROM floral_department_products WHERE id = #{@id};")
  # end
end
