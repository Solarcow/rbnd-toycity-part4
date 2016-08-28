

module Analyzable
  # Your code goes here!
  def average_price(products)
  	price_array = []

  	products.each do |product|
  		price_array << product.price.to_f
  	end
  	sum = 0
  	price_array.each do |price|
  		sum += price
  	end
  	return ( sum / products.length).round(2)
  end

  def print_report(products)
    report = "Average price: #{average_price(products).to_s}\n"

    brand_total = count_by_brand(products)
    name_total = count_by_name(products)

    report += "\n Inventory by Brand:"
    brand_total.each do |brand, total|
      report += "\n    - #{brand}: #{total} "
    end

    report += "\n Inventory by Name:"
    name_total.each do |name, total|
      report += "\n    - #{name}: #{total} "
    end
    report 
  end

  def count_by_brand(products)
    brand = Hash.new(0)
    products.each do |product|
      brand[product.brand] += 1
    end
    return brand
  end

  def count_by_name(products)
    name = Hash.new(0)
    products.each do |product|
      name[product.name] += 1
    end
    return name
  end

end
