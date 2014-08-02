require 'unirest'
require 'open-uri'

class News < ActiveRecord::Base
	belongs_to :source
	belongs_to :sourcefeed
	has_many :news_tags
	has_many :tags, :through=>:news_tags
	belongs_to :city
	has_attached_file :picture,:default_url => '/images/newspaper.png'

	belongs_to :category
	default_scope order("date DESC, id DESC")
	
	def create_tags
		content_sanitize=content.html_safe
		content_sanitize=ActionView::Base.full_sanitizer.sanitize(title+"\n"+content_sanitize)

			response = Unirest.post( "https://debaetsa-machine-linking.p.mashape.com/annotate", 
			  headers: { 
		    "X-Mashape-Authorization" => configatron.mashape.apikey,
		    "Accept" => "application/json"
			 },
			 
			  parameters: { 
			    "text" =>content_sanitize,
			    "output_format" => "json",
			    "id" => "",
			    "include_text" => "",
			    "jsonp" => "<jsonp>",
			    "disambiguation" => "1",
			    "abstract"=>"1",
			    "min_weight"=>"0.3"

			  }
			  )
			#hash = JSON.parse(response.body)
			#obj = Hashie::Mash.new response.to_json
			#puts obj.inspect
		

			 obj=Hashie::Mash.new response.body
			 keyword_array=[]
			 obj.annotation.keyword.each do |k|
			 	keyword={}
			 	keyword["name"]=k.form
			 	keyword["abstract"]=k.abstract.encode('utf-8', 'binary', invalid: :replace, undef: :replace, replace: '')
			 	keyword["page"]=k.sense.page
			 	tag=Tag.find_by_name(k.form.strip)
			 	unless tag
			 		tag=Tag.create(keyword)
			 	end

			 	#creates the newstag
			 	NewsTag.create({:tag_id=>tag.id, :news_id=>id})

			 	

			 #	keyword_array.push keyword


			 end
			 keyword_array
			

	end

end
