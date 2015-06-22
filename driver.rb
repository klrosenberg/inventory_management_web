module Driver
  
  def self.list_menu_options
    # Give user options in initial menu.
    puts "Please pick from the following options:"
    # Add a product- follow up asking for category, price, location and quantity.
    puts "1) Add a product."
    # Update any given field for a specific product or delete.
    puts "2) Update an existing product."
    # Print list of products- individual, all, by location or by category.
    puts "3) List product records."
    # Update or create location.
    puts "4) Add or update a location."
    # Option to delete product, location or category.
    puts "5) Delete an entry."
    # Option to quit.
    puts "6) Quit."
  end
   
  # List through Array of all Floral Department products.
  def self.list_products
    FloralDepartmentProduct.all.each do |object|
      puts "#{object.id}) #{object.product}: #{object.quantity} at #{object.cost}"
    end
  end
  
  # List through Array of all categories.
  def self.list_categories
    ProductCategory.all.each do |object|
      puts "#{object.id}) #{object.category_name}"
    end
  end
  
  # List through Array of all locations.
  def self.list_locations
    Location.all.each do |object|
      puts "#{object.id}) #{object.location_name}"
    end
  end
  
  # List through columns to update.
  def self.column_update 
    puts "Which column would you like to update?"
    puts "- Product"
    puts "- Category_id"
    puts "- Cost"
    puts "- Location_id"
    puts "- Quantity"
  end
end