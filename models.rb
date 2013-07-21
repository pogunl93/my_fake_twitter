class User < ActiveRecord::Base

	def full_name 
		if !lname.nil?
			fname+ " " +lname
		else
			fname  
		end
	end 

	def location
		if !city.nil? && !state.nil?
			fname+ " " +lname
		else
			nil  
		end
		city+ ", " +state
	end 
 
	has_many :tweets 
end

class Tweet < ActiveRecord::Base
	belongs_to :user 
end 