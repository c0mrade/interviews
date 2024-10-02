class MaxPrice
	def self.call(price_arry)
		minimum_price =  price_arry[0]
		most_profit = 0

		price_arry.each_with_index do |number, i|
			if number < minimum_price
				minimum_price = number
			end

			new_max_profit = (number - minimum_price) 
			most_profit = new_max_profit if new_max_profit > most_profit
		end

		most_profit
	end
end
