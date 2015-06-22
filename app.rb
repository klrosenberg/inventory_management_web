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

get "/welcome" do
  erb :"welcome"
end

get "/save" do
  @new_product = FloralDepartmentProduct.new(nil, "product" => params['product'], "category_id" => params['category_id'], "cost" => params['cost'].to_i, "location_id" => params['location_id'], "quantity" = params['quantity'].to_i)
  if @new_product.save
    erb :"/updated_database"
  else
    "Error"
end

get "/:something" do
  erb :"#{params["something"]}"
end

