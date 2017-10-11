module RepairqNavigation

	def navigate_to()


	def authenticate_agent(path = "/", options = {})
		@agent = Mechanize.new
		login_params = {
			"UserLoginForm[username]" => options[:user] || default_login,
			"UserLoginForm[password]" => options[:pin] || default_pin,
			"UserLoginForm[currentLocation]" => options[:location] || location
		}
		page = @agent.post repairq_post_login_path, login_params
		# TODO: handle failed login/bad password/incorrect username/prohibited location
		# return username or false
		page.code == "200" ? @agent : false
	end


end