class CreateTweets < ActiveRecord::Migration
  def up
  	create_table :tweets do |u|
  		u.text :tweet_data
  		u.integer :user_id
  		u.datetime :created_at
	end 
end

  def down
  	drop_table :tweets
  end
end
