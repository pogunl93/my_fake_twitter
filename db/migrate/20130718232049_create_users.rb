class CreateUsers < ActiveRecord::Migration
  def up
  	create_table :users do |u|
  		u.string :fname
  		u.string :lname
  		u.string :password
  		u.string :email
  		u.string :username
  		u.text :bio
  		u.string :url
  		u.string :city
  		u.string :state
  end
end 

  def down
  	drop_table :users
  end
end
