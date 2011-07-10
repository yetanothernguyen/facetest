require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'environment')

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  enable :sessions
  use Rack::Flash
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
	@apps = FacebookApp.all
  haml :index
end

post '/facebook_apps' do
	app = FacebookApp.new(params[:app])
	if app.save
		flash.now[:notice] = "App successfully added"
	else

	end

	redirect '/'
end

post '/users' do
  app = FacebookApp.get(params[:app])
  app.create_user!

  redirect "/facebook_app/#{app.id}"
end

get '/facebook_app/:id' do
  @app = FacebookApp.get(params[:id])
  @app.load_users!
  @accounts = app.users
  
  haml :facebook_app
end
