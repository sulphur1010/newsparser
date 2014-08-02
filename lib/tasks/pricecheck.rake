namespace :item do
	task :check=>:environment do
		start=Time.new
		items=Item.all

		puts "#{Item.count} items in database. Check started at #{start.inspect}"
		#logger.info("Starting Price Checker for #{Item.count} items")
		items.each do |item|
			product= Product.create(item.url)
			product.fetch
			puts "#{item.name.truncate(12)} price: #{item.price}>#{product.price}"

			if(product.price.to_f!=item.price)
				#if the  prices are different, update the new price
				
				
				puts(" - - - Aha price changed from #{item.price}#{item.currency.code} to #{product.price}#{item.currency.code}")

				# TODO make an entry in a seperate table to track the prices over the generations

				

				if(product.price.to_f<item.price)
					t_start=Time.new
					#product price is less than item price. Now change the stuff
					puts(" - - - Sending emails with content: Price changed from #{item.price} to #{product.price} at: #{t_start.inspect} to #{item.item_users.count} users")
					item.item_users.each do |item_user|
						if (item_user.price_alert)

							ItemMailer.alert(item,item_user.user,product.price).deliver
						end
					end
					t_end=Time.new
					puts(" - - - Emails ended  at: #{t_end.inspect}") 

				end

				item.price=product.price
				item.save
			end
			stop=Time.new
			puts "Check ended  at #{stop.inspect}"

			puts "\n"

		end 
	end

end 