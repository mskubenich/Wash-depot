# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create test users

puts "Users creation"

User.delete_all

User.create(id: 1, :firstname => "John", :lastname => "Carney", :email => "john.carney@washdepot.com", :password => "123456789", 
			:password_confirmation => "123456789")
User.create(id: 2, :firstname => "Scott", :lastname => "Yorn", :email => "scott.yorn@washdepot.com", :password => "123456789", 
			:password_confirmation => "123456789")
User.create(id: 3, :firstname => "Lee", :lastname => "Leyva", :email => "lee.leyva@washdepot.com", :password => "123456789", 
			:password_confirmation => "123456789")

User.create(id: 4, :firstname => "manager", :lastname => "manager", :email => "manager@washdepot.com", 
			:password => "manager1", :password_confirmation => "manager1", :user_type => 1)

User.create(id: 5, :firstname => "admin", :lastname => "admin", :email => "admin@washdepot.com", 
			:password => "admin123", :password_confirmation => "admin123", :user_type => 2)


puts "Statuses creation"

Status.delete_all
Status.create(id: 1, name: "Queued")

puts "Problem Areas creation"

ProblemArea.delete_all
ProblemArea.create(id: 1, name: "Conveyor Chain")
ProblemArea.create(id: 2, name: "Electrical Equip Room")
ProblemArea.create(id: 3, name: "Mitter Curtain")
ProblemArea.create(id: 4, name: "Wheel Blasters")
ProblemArea.create(id: 5, name: "Plumbing Water")
ProblemArea.create(id: 6, name: "POS System")

puts "Locations creation"

Location.delete_all
Location.create(id: 1, name: "Location 001")
Location.create(id: 2, name: "Location 002")
Location.create(id: 3, name: "Location 003")
Location.create(id: 4, name: "Location 004")

puts "Pictures creation"

Picture.delete_all

puts "Request creation"

Request.delete_all
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 1, 
			   description: "Conveyor chain is starting to break", importance: 2, status_id: 1, completed: 0, location_id: 1) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 2, 
			   description: "Water leak in electrical room", importance: 2, status_id: 1, completed: 0, location_id: 1) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 2, problem_area_id: 3, 
			   description: "Mitter curtain is squeaking", importance: 1, status_id: 1, completed: 0, location_id: 1) #pictures !!!

Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 1, 
			   description: "Conveyor chain is starting to break", importance: 2, status_id: 1, completed: 0, location_id: 2) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 2, 
			   description: "Water leak in electrical room", importance: 2, status_id: 1, completed: 0, location_id: 2) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 2, problem_area_id: 3, 
			   description: "Mitter curtain is squeaking", importance: 1, status_id: 1, completed: 0, location_id: 2) #pictures !!!

Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 1, 
			   description: "Conveyor chain is starting to break", importance: 2, status_id: 1, completed: 0, location_id: 3) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 2, 
			   description: "Water leak in electrical room", importance: 2, status_id: 1, completed: 0, location_id: 3) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 2, problem_area_id: 3, 
			   description: "Mitter curtain is squeaking", importance: 1, status_id: 1, completed: 0, location_id: 3) #pictures !!!

Request.all.each do |request|
	request.pictures << [Picture.create, Picture.create, Picture.create]
end