require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  # Your code goes here!
  id = 1
  10.times do 
  	name = Faker::Commerce.product_name
  	brand = Faker::Company.name
  	price = Faker::Commerce.price
  	Product.new(id: id, brand: brand, name: name, price: price)
  	id += 1
  end
end
