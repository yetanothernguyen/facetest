require "#{File.dirname(__FILE__)}/spec_helper"

describe 'facebook_app' do
  before(:each) do
    @app = FacebookApp.new(:name => "test app", :app_id => "app id", :app_secret => "app secret")
  end

  describe "validations" do

    it 'should be valid' do
      @app.should be_valid
    end

    it 'should require a name' do
      @app = FacebookApp.new(:app_id => "app id", :app_secret => "app secret")
      @app.should_not be_valid
      @app.errors[:name].should include("Name must not be blank")
    end

    it 'should require a app id' do
      @app = FacebookApp.new(:name => "test app", :app_secret => "app secret")
      @app.should_not be_valid
      @app.errors[:app_id].should include("App must not be blank")
    end

    it 'should require a app secret' do
      @app = FacebookApp.new(:name => "test app", :app_id => "app id")
      @app.should_not be_valid
      @app.errors[:app_secret].should include("App secret must not be blank")
    end
  end

  describe "associations" do
    let(:app) { Factory(:facebook_app) }
    
    before do
      @user = app.users.create(:name => "Example")
    end
    
    it "should associate facebook_app with users" do
      @user.facebook_app.should == app
    end

    it "should associate user with facebook_app" do
      app.users.should == [@user]
    end
  end

  describe "#load_users!" do
    let(:app) { Factory(:facebook_app, :app_id => "142560682427966", :app_secret => "9d6ffffafacff9e624b62502483c5f09", :app_access_token => "142560682427966|BwQgCypTZ6g-1D65V0ZNktIF9ZI") }

    it "should load users" do
      app.load_users!
      ap app.users
    end
  end
end
