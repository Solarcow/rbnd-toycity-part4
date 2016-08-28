class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attrib|
    	new_finder_method = %{
    		def self.find_by_#{attrib}(item)
    			all.each do |product|
    				if product.#{attrib} == item
    					return product
    				end
    			end
    		end
    	}
    	self.class_eval new_finder_method
    end
  end
end
