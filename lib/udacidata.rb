require_relative 'find_by'
require_relative 'errors'
require_relative 'product'
require 'csv'

class Udacidata
  # Your code goes here!
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  create_finder_methods :brand, :name

	  def update(opts = {})
	  	@id = self.id
	  	@brand = opts[:brand] || self.brand
	  	@name = opts[:name] || self.name
	  	@price = opts[:price] || self.price
	  	self.class.destroy(@id)

	  	CSV.open(@@data_path, "a+") do |csv|
	  		csv << [@id, @brand, @name, @price]
	  	end
	  	return self

	  end

  class << self
  
	  def create(opts = {})
	  	brand = opts[:brand]
	  	name = opts[:name]
	  	price = opts[:price]
	  	product = self.new(brand: brand, name: name, price: price)

	  	CSV.open(@@data_path, "a+") do |csv|
	  		csv << [product.id, product.brand, product.name, product.price]
	  	end
	  	return product
	  end

	  def destroy(id)
	  	product = self.find(id)

	  	table = CSV.table(@@data_path)
	  	table.delete_if do |row|
	  		row[:id] == id
	  	end

	  	File.open(@@data_path, 'w') do |row|
	  		row.write(table.to_csv)
	  	end
	  	product
	  end

	  def all
	  	data = []
	  	CSV.foreach(@@data_path, headers:true) do |row|
	  		id, brand, name, price = row["id"], row["brand"], row["product"], row["price"]
	  		data << Product.new(id: id, brand: brand, name: name, price: price)
	  	end
	  	return data
	  end

	  def first(n = 1)
	  	if n > 1
	  		return self.all.first(n)
	  	else
	  		return self.all.first
	  	end
	  end

	  def last(n = 1)
	  	if n > 1
	  		return self.all.last(n)
	  	else
	  		return self.all.last
	  	end
	  end

	  def find(id)
	  	self.all.each do |search|
	  		if search.id == id
	  			return search
	  		end
	  	end
	  	raise ProductNotFoundError, "The ID: #{id} can't be found"
	  end

	  def where(args = {})
	  	@products = []
	  	self.all.each do |product|
	  		brand = product.brand
	  		name = product.name
	  		if (brand == args[:brand] || name == args[:name])
	  			@products << product
	  		end
	  	end
	  	return @products
	  end

	end
end
