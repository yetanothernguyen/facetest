# example model file
class FacebookApp
  include DataMapper::Resource

  property :id,         			Serial
  property :name,       			String
  property :app_id,						String
  property :app_secret,				String
  property :app_access_token,	String
  property :url,              String
  property :created_at, 			DateTime
  property :updated_at, 			DateTime

  validates_presence_of :name, :app_id, :app_secret

  has n, :users

  before :create, :get_access_token

  def load_users!
		facebook = get_facebook
		users = facebook.get_users
		users.each do |user|
			if existing_user = self.users.first(:fb_id => user["id"])
				existing_user.update_from_facebook!(user)
			else
				details = facebook.get_user_details(user["id"],user["access_token"])
				facebook.set_user_password(user["id"], user["access_token"], "facebook")
				user["password"] = "facebook"
        record = User.new_from_facebook(user, details)
        record.facebook_app = self
				result = record.save
			end
		end
  end

  def create_user!
  	facebook = get_facebook
  	user = facebook.create_user
  	details = facebook.get_user_details(user["id"],user["access_token"])
		facebook.set_user_password(user["id"], user["access_token"], "facebook")
		user["password"] = "facebook"
		record =  User.new_from_facebook(user, details)
		record.facebook_app = self
    record.save
  end

  def get_facebook
  	return Facebook.new(self.app_id, self.app_secret, self.app_access_token)
  end

  protected

  def get_access_token
  	if self.app_access_token.blank?
  		facebook = Facebook.new(self.app_id, self.app_secret)
  		self.app_access_token = facebook.get_access_token
  	end
  end
end
