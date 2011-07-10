class Facebook
	include HTTParty
	base_uri "https://graph.facebook.com"
	format :json

	def initialize(app_id, app_secret, access_token=nil)
		@access_token = access_token
		@app_id = app_id
		@app_secret = app_secret
	end

	def create_user
		resp = self.class.post("/#{@app_id}/accounts/test-users", :query => {:access_token => @access_token, :installed => "false", :permissions => "email,user_birthday,user_hometown"})
		return resp.parsed_response
	rescue Exception => e
	end

	def get_users
		resp = self.class.get("/#{@app_id}/accounts/test-users", :query => {:access_token => @access_token})
		return resp.parsed_response["data"]
	rescue Exception => e
		return []
	end

	def get_access_token
		resp = self.class.get("/oauth/access_token", :query => {:client_id => @app_id, :client_secret => @app_secret, :grant_type => "client_credentials"})
		@access_token = resp.parsed_response.split("=")[1]
		return @access_token
	rescue Exception => e
		return ""
	end

	def get_user_details(id, access_token)
		resp = self.class.get("/#{id}", :query => {:access_token => access_token})
		return resp.parsed_response
	end

	def set_user_password(id, access_token, password)
		resp = self.class.post("/#{id}", :query => {:password => password, :access_token => access_token})
		return resp.parsed_response
	end
end