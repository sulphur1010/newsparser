class Tag < ActiveRecord::Base
		has_many :news_tags
		has_many :news, :through=>:news_tags
		has_attached_file :picture
end
