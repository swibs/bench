module ApplicationHelper


	def cents_to_currency(i)
		number_to_currency(i.to_f/100, precision: 2)
	end
end
