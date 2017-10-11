class Repairq < ApplicationRecord

	#include RepairqNavigation

	REPAIRQ_DOMAIN = "repairq.io".freeze
	REPAIRQ_HOST = "https://%s.%s" % [@server, REPAIRQ_DOMAIN]	
	
	REVENUE_DETAIL_PATH = "/report/revenueDetail".freeze
	SUMMARY_REPORT_PATH = "/report/summaryReport".freeze
	PROFILE_PATH = "/staff/profile".freeze

	LOGIN_PATH = "/site/login".freeze
	
	attr_accessor :agent

	def self.login_to(name, options = {})
		# DEPRECATE
		#r = find_by_name(name)
		#r.login(options)
	end

	def login(options = {})
		set_agent
		page = agent.get REPAIRQ_HOST
		form = page.forms.first
		form.field_with(name: "UserLoginForm[username]").value = options[:user] || default_login
		form.field_with(name: "UserLoginForm[password]").value = options[:pin] || default_pin
		form.field_with(name: "UserLoginForm[currentLocation]").value = options[:location] || location
		page = form.click_button
		# TODO: handle failed login/bad password/incorrect username/prohibited location
		# return username or false
		page.title == "RepairQ" ? page.at(".username").text.strip : false
	end

	def sales_report(options = {})
		date = !!options[:date] ? Date.parse(options[:date].to_s) : Date.today
		puts "authenticating"
		set_authenticated_agent
		sales = Hash.new
		puts "loading revenue report"
		page = @agent.get REPAIRQ_HOST + REVENUE_DETAIL_PATH
		form = page.forms.last		
		form.field_with(name: "filter[ticketDateStart]").value = date.strftime('%m/%d/%Y')
		form.field_with(name: "filter[ticketDateEnd]").value = date.strftime('%m/%d/%Y')
		form.field_with(name: "filter[location][]").value = ["3"]
		form.field_with(name: "filter[warranty_provider]").value = "all"
		# get all sales
		puts "filtering all sales"
		form.field_with(name: "filter[closed_only]").value = "all"
		page = form.click_button
		sales[:net_sales] = page.css("div .right.tooltip-toggle h6").first.text.gsub(/[^0-9-]/,"").to_i
		# get open sales
		puts "filtering open sales"
		form.field_with(name: "filter[closed_only]").value = "open"
		page = form.click_button
		sales[:open_ticket_sales] = page.css("div .right.tooltip-toggle h6").first.text.gsub(/[^0-9-]/,"").to_i
		# => get closed sales
		puts "filtering closed sales"
		form.field_with(name: "filter[closed_only]").value = "closed"
		page = form.click_button
		sales[:closed_ticket_sales] = page.css("div .right.tooltip-toggle h6").first.text.gsub(/[^0-9-]/,"").to_i
		# => 
		puts "loading summary report"
		page = @agent.get REPAIRQ_HOST + SUMMARY_REPORT_PATH
		form = page.forms.last
		form.field_with(name: "filter[ticketDateStart_local]").value = date.strftime('%m/%d/%Y')
		form.field_with(name: "filter[ticketDateEnd_local]").value = date.strftime('%m/%d/%Y')
		puts "filtering date"
		page = form.click_button
		sales[:deposit] = page.search("tr").at("td:contains('Cash')").parent.search("td").last.text.gsub(/[^0-9-]/,"").to_i
		sales[:tickets_created] = page.search("tr").at("td:contains('Created')").parent.search("td").last.text
		
		logout_agent
		return sales
	end

	def username
		set_authenticated_agent
		page = @agent.get REPAIRQ_HOST + PROFILE_PATH
		logout_agent
		page.css('.username').text.strip
	end

	#private

	def set_agent
		@agent = Mechanize.new
	end

	def authenticate!(options = {})
		login_params = {
			"UserLoginForm[username]" => options[:user] || default_login,
			"UserLoginForm[password]" => options[:pin] || default_pin,
			"UserLoginForm[currentLocation]" => options[:location] || location
		}

		
		page = @agent.post repairq_post_login_path, login_params
	end

	def set_authenticated_agent(path = "/")
		@agent = Mechanize.new
		# TODO: handle failed login/bad password/incorrect username/prohibited location
		# return username or false
		page.code == "200" ? @agent : false
	end

	def logout_agent
		@agent.get(repairq_host + "/site/logout")
	end

	

end
