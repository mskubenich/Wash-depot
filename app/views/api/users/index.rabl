
collection @users, :object_root => false

attributes :firstname, :lastname, :email

#Send user type
node :user_type do |user|
	user.user_type.to_s
end

#Send user.id as identifier 
node :identifier do |user|
	user.id.to_s
end