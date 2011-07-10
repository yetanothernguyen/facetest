require "#{File.dirname(__FILE__)}/spec_helper"

describe 'facebook' do
  before(:each) do
    @facebook = Facebook.new('142560682427966', '9d6ffffafacff9e624b62502483c5f09', '142560682427966|BwQgCypTZ6g-1D65V0ZNktIF9ZI')
  end

  it 'should get access token' do
  	access_token = @facebook.get_access_token
  	ap access_token
  end

  it 'should get users' do
    users = @facebook.get_users
    users.each do |user|
      detail = @facebook.get_user_details(user["id"],user["access_token"])
      ap detail
    end
  end
end
