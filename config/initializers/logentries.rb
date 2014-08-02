
if Rails.env.production?
	Rails.logger = Le.new('62e3656f-53be-425c-bf8b-f5ca639b4363')
elsif Rails.env.staging?
	Rails.logger = Le.new('6cc645fe-40fb-44b8-b23b-f49156e29458')
end

