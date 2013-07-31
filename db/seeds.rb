# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create test users

puts 'Create roles'

Role.destroy_all

Role.create(name: :admin)
Role.create(name: :regular)
Role.create(name: :manager)

puts "Users creation"

User.delete_all

regular = User.create(:firstname => "John", :lastname => "Carney", :email => "regular@g.com", :password => "123456",
			:password_confirmation => "123456")
regular.roles = [Role.find_by_name(:regular)]

manager = User.create(:firstname => "manager", :lastname => "manager", :email => "manager@g.com",
			:password => "123456", :password_confirmation => "123456")
manager.roles = [Role.find_by_name(:manager)]

admin = User.create(:firstname => "admin", :lastname => "admin", :email => "admin@g.com",
			:password => "123456", :password_confirmation => "123456")
admin.roles = [Role.find_by_name(:admin)]

puts "Statuses creation"

Status.delete_all
Status.create(id: 1, name: "Queued")
Status.create(id: 2, name: "Parts Ordered")
Status.create(id: 3, name: "Scheduled")
Status.create(id: 4, name: "Under Review")

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

puts "Importances creation"

Importance.delete_all
Importance.create(id: 1, name: "Low")
Importance.create(id: 2, name: "Urgent")
Importance.create(id: 3, name: "Normal")

puts "Request creation"

Request.delete_all
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 1, 
			   description: "Conveyor chain is starting to break", importance_id: 2, status_id: 1, completed: 0, location_id: 1) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 2, 
			   description: "Water leak in electrical room", importance_id: 2, status_id: 1, completed: 0, location_id: 1) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 2, problem_area_id: 3, 
			   description: "Mitter curtain is squeaking", importance_id: 1, status_id: 1, completed: 0, location_id: 1) #pictures !!!

Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 1, 
			   description: "Conveyor chain is starting to break", importance_id: 2, status_id: 1, completed: 0, location_id: 2) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 2, 
			   description: "Water leak in electrical room", importance_id: 2, status_id: 1, completed: 0, location_id: 2) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 2, problem_area_id: 3, 
			   description: "Mitter curtain is squeaking", importance_id: 1, status_id: 1, completed: 0, location_id: 2) #pictures !!!

Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 1, 
			   description: "Conveyor chain is starting to break", importance_id: 2, status_id: 1, completed: 0, location_id: 3) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 1, problem_area_id: 2, 
			   description: "Water leak in electrical room", importance_id: 2, status_id: 1, completed: 0, location_id: 3) #pictures !!!
Request.create(creation_date: Time.at(rand * Time.now.to_i), user_id: 2, problem_area_id: 3, 
			   description: "Mitter curtain is squeaking", importance_id: 1, status_id: 1, completed: 0, location_id: 3) #pictures !!!
