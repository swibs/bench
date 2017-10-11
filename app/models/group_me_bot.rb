class GroupMeBot < ApplicationRecord
	
	def bots
		client.bots
	end

	def post(text)
		client.bot_post(self.bot_id, text)	
	end

	private

	def client
		GroupMe::Client.new(token: self.token)
	end

	


end
