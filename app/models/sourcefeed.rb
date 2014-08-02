require 'open-uri'

class Sourcefeed < ActiveRecord::Base
  belongs_to :source
  belongs_to :city
  belongs_to :category

  def parse

  	feed=open(url).read
  	json=JSON.parse(feed)
   

  end

  def getnews
      
      feed=Hashie::Mash.new(parse)
      items=feed.value.items.reverse
      items.each do |item|
        puts "->>#{item.title} "
        unless(News.find_by_url(item.url))  
          news_item=News.new
          news_item.title=item.title
          news_item.content=item.content
          news_item.summary=item.description
          news_item.date=item.date
          news_item.url=item.url
          news_item.sourcefeed_id=id
          news_item.source_id=source_id
          news_item.category_id=category_id
          news_item.picture=open(item.image)

          cityname=item.location.downcase
          if cityname.include? "/"
            cityname=cityname.split(/\//)[0]

          end
          city=City.where("lower(name)=?",cityname).first
          if(city)
            news_item.city_id=city.id
          else
            city=City.create({:name=>cityname.humanize})
            news_item.city_id=city.id
          end
          if @category_id
            news_item.category_id=@category_id
          end
          
          news_item.save
          news_item.create_tags


          puts "--> News not found in database, adding... News ID: #{news_item.id}"

        end
      end
      
  end

  def self.sync
    t_start = Time.now
    puts "-----------------Starting Operation------------------"
  	self.all.each do |f|
      t_fstart=Time.now
      puts ">>>#{f.name} "
  	  f.getnews
      t_fend=Time.now
      puts ">>>Feed completed in #{t_fend-t_fstart} seconds\n\n"
    end
  	puts "------Operation completed in #{Time.now-t_start} seconds ----"

  end
end
