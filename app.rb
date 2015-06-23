require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require "sqlite3"

DATABASE = SQLite3::Database.new("inventory.db")

DATABASE.results_as_hash = true

# Create new table storing names of floral department products.
DATABASE.execute('CREATE TABLE IF NOT EXISTS floral_department_products (id INTEGER PRIMARY KEY, product TEXT UNIQUE, category_id INTEGER, cost DECIMAL, location_id INTEGER, quantity INTEGER);')

# Create new table storing names of product categories.
DATABASE.execute('CREATE TABLE IF NOT EXISTS product_categories (id INTEGER PRIMARY KEY, category_name TEXT UNIQUE);')

# Create new table storing names of locations
DATABASE.execute('CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, location_name TEXT UNIQUE);')

# -----------------------------------------------------------------------------
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
require_relative "locations.rb"
require_relative "product_categories.rb"
require_relative "floral_department_products.rb"
require_relative "driver.rb"

########################### Begin Web UX ######################################

# -----------------------------------------------------------------------------
# Menu
# -----------------------------------------------------------------------------
get "/welcome" do
  erb :"welcome"
end

# -----------------------------------------------------------------------------
# Adds product to database.
# -----------------------------------------------------------------------------
get "/save" do
  if FloralDepartmentProduct.add({"product" => params['product'], "category_id" => params['category_id'], "cost" => params['cost'].to_i, "location_id" => params['location_id'], "quantity" => params['quantity'].to_i})
    erb :"/updated_database"
  else
    @error = true
    erb 
  end
end

# -----------------------------------------------------------------------------
# List of existing products to select and edit
# -----------------------------------------------------------------------------
get "/existing_products" do
  erb :"/existing_products"
end

# -----------------------------------------------------------------------------
# 
# -----------------------------------------------------------------------------
get "/update_product" do
  @product = FloralDepartmentProduct.find(params["id"].to_i)
  erb :"/update_product"
end

# -----------------------------------------------------------------------------
# 
# -----------------------------------------------------------------------------
get "/update_product/save" do
  @product = FloralDepartmentProduct.find(params["id"].to_i)
  @product.product = params["product"]
  @product.category_id = params["category_id"].to_i
  @product.location_id = params["location_id"].to_i
  @product.cost = params["cost"].to_i
  @product.quantity = params["quantity"].to_i
  @product.save
  if @product.save
    erb :"/updated_database"
  else
    erb :"/update_product"
  end
end

# -----------------------------------------------------------------------------
# 
# -----------------------------------------------------------------------------
get "/delete" do
  @product = FloralDepartmentProduct.find(params["id"].to_i)
  if @product.delete
    erb :"/updated_database"
  else
    "Error"
  end
end


# -----------------------------------------------------------------------------
# 
# -----------------------------------------------------------------------------
get "/:something" do
  erb :"#{params["something"]}"
end

