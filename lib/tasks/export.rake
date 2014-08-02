namespace :cities do
	task :export=>:environment do
	puts "["
		City.all.each do |city|
			
			puts "{:name=>'#{city.name.strip}',:latitude=>'#{city.latitude.strip}',:longitude=>'#{city.longitude.strip}',:state=>'#{city.state.strip}'},\n"
		end
	puts "]"
	end
end

