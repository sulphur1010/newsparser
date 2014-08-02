module Users::RegistrationsHelper
		
	def get_country
	    if(request.location.country)
	      Country.find_by_name(request.location.country)
	    end
    
 	end
end
