collection @requests, :object_root => false

attributes :id, :creation_date, :completed, :last_reviewed

node :desc do |request|
	request.description
end

node :user do |request|
    if request.user
	    request.user.firstname + ' ' + request.user.lastname
	end
end

node :status do |request|
	request.status.name if request.status
end

node :importance do |request|
	request.importance.name if request.importance
end

node :problem_area do |request|
   request.problem_area.name if request.problem_area
end

node :location do |request|
	request.location.name if request.location
end

node :picture1 do |request|
    request.picture1.url if request.picture1_file_size
end

node :picture2 do |request|
    request.picture2.url if request.picture2_file_size
end

node :picture3 do |request|
    request.picture3.url if request.picture3_file_size
end

