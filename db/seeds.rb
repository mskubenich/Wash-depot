# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create test users

puts "Users creating"

User.create(:firstname => "simple", :lastname => "user", :email => "suser@washdepot.com", :password => "suser123", :password_confirmation => "suser123")

User.create(:firstname => "manager", :lastname => "manager", :email => "manager@washdepot.com", 
			:password => "manager1", :password_confirmation => "manager1", :user_type => 1)

User.create(:firstname => "admin", :lastname => "admin", :email => "admin@washdepot.com", 
			:password => "admin123", :password_confirmation => "admin123", :user_type => 2)