class Category < ActiveRecord::Base
	has_many :sourcefeeds
	has_many :news
end
