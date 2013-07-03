object @request => nil

attributes :id, :completed

node :priority do |request|
	request.importance
end

node :picture1_id do |request|
	request.picture1.id if request.picture1
end

node :picture2_id do |request|
	request.picture2.id if request.picture2
end

node :picture3_id do |request|
	request.picture3.id if request.picture3
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