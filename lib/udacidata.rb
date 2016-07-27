require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  attr_reader :data_path
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  class << self
  
	  def create(args = {})
	  	product = self.new(args)
	  	CSV.open(@@data_path, "a+") do |csv|
	  		csv << [product.id, product.brand, product.name, product.price]
	  	end
	  end
	end
end
