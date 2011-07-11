class User
  include DataMapper::Resource

  property :id,         			Serial
  property :fb_id,            String
  property :fb_access_token,  Text
  property :email,            Text
  property :password,         String
  property :name,							Text
  property :first_name,				String
  property :middle_name,			String
  property :last_name,				String
  property :link,							String
  property :birthday,					Date
  property :gender,						String
  property :login_url,        Text
  property :created_at, 			DateTime
  property :updated_at, 			DateTime

  belongs_to :facebook_app

  def self.new_from_facebook(user, details)
    record = User.new
    record.fb_id = user["id"]
    record.fb_access_token = user["access_token"]
    record.login_url = user["login_url"]
    record.password = user["password"]
    record.email = details["email"]
    record.name = details["name"]
    record.gender = details["gender"]
    record.first_name = details["first_name"]
    record.last_name = details["last_name"]
    record.middle_name = details["middle_name"]
    return record
  end

  def update_from_facebook!(user)
    self.fb_id = user["id"]
    self.fb_access_token = user["access_token"]
    self.login_url = user["login_url"]
    self.password = user["password"] if self.password.blank?
    self.save
  end
end
