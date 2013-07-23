require 'rubygems'
require 'haml'
require 'sinatra'
require 'sinatra/activerecord'
require 'scoped_search'
require 'stringio'
configure(:development){ set :database, "sqlite3:///Twitter_DB.sqlite3" }
require './models'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'

enable :sessions 
use Rack::Flash, :sweep => true 

set :sessions => true

require './helpers'

get '/' do
	@tweet = Tweet.all 
	haml :news_feed 
end

get '/users/sign_up' do 
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
			redirect '/users/sign_in'
		end 
	else 
		flash[:notice] = "Your username was not found"
		redirect '/users/sign_in'
	end 
end 

get '/sign_out' do
	session[:user_id] = nil 
	flash[:notice] = "You have successfully signed out"
	redirect '/'
end

get '/profile_list' do
	@users = User.all
	haml :profile_list
end 

get '/users/:id' do 
	@user = User.find(params[:id])
	haml :profile
end 

post '/users/:id' do 
	@tweet = Tweet.create(:tweet_data => params[:tweet])
	@user = User.find(params[:id])
	@user.tweets << @tweet
	redirect '/' 
end 

get '/search' do
	haml :search
end 

post '/search_results' do
	@text_input = Tweet.where("tweet_data like '%#{params[:search_query]}%'")
end 


