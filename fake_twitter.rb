require 'rubygems'
require 'haml'
require 'sinatra'
require 'sinatra/activerecord'
configure(:development){ set :database, "sqlite3:///Twitter_DB.sqlite3" }
require './models'

require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'

enable :sessions 
use Rack::Flash, :sweep => true 

set :sessions => true

require './helpers'

get '/' do
	@users = User.all
	haml :home 
end

get '/sign_up' do 
	haml :sign_up
end 

post '/users/sign_up' do 
	User.create(params)
	@users = User.all 
	redirect '/'
end 

get '/users/sign_in' do
	haml :sign_in
end 
	
post '/users/sign_in' do 
	@user = User.where(:username => params[:username]).first
	if @user 
		if @user.password == params[:password]
			session[:user_id] = @user.id
			flash[:notice] = "Welcome back, #{@user.fname}!" 
			redirect '/'
		else 
			flash[:notice] = "Your password was wrong"
			redirect '/sign_in'
		end 
	else 
		flash[:notice] = "Your username was not found"
		redirect '/sign_in'
	end 
end 

get '/users/:id' do 
	@user = User.find(params[:id])
	haml :profile
end 

post '/new_tweet' do 
	@tweet = Tweet.create(:text => params[:tweet])
	@user = User.find(params[:id])
	@user.tweets << @tweet
	redirect '/new_tweet' 
end 
