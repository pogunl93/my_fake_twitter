require 'rubygems'
require 'haml'
require 'sinatra'
require 'sinatra/activerecord'
set :database, "sqlite3:///Twitter_DB.sqlite3"
require './models'


get '/' do
	@users = User.all
	haml :home 
end

get '/sign_up' do 
	haml :sign_up
end 