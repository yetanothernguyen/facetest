require "#{File.dirname(__FILE__)}/spec_helper"

describe 'main application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  it 'should show the default index page' do
    get '/'
    last_response.should be_ok
  end

  it 'should show apps list' do
  	app1 = Factory(:facebook_app)
  	app2 = Factory(:facebook_app)
  	get '/'
  	last_response.body.should include(app1.name)
    last_response.body.should include(app2.name)
  end
end
