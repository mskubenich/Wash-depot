collection @requests , :object_root => false

attributes :id, :creation_date, :completed, :last_reviewed

node :priority do |request|
	request.importance
end

node :desc do |request|
	request.description
end

node :status do |request|
	request.status.name if request.status
end

node :problem_area do |request|
   request.problem_area.name if request.problem_area
end

node :location do |request|
	request.location.name if request.location
end
