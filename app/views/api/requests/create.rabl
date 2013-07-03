object @request => nil

attributes :id, :completed

node :priority do |request|
	request.importance
end

node :creation_date do |request|
	request.creation_date.to_time.to_i.to_s
end

node :desc do |request|
	request.description
end

node :problem_area do |request|
   request.problem_area.name if request.problem_area
end

node :status do |request|
	request.status.name if request.status
end

child :pictures do
	attribute :id
end

node :last_review do |request|
	if request.last_reviewed
		request.last_reviewed.to_time.to_i.to_s
	else
		""
	end
end

node :location do |request|
	request.location.name if request.location
end