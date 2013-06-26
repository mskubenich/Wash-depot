object @request

attributes :completed, :description
attributes :importance => :priority

node :creation_date do |request|
	request.creation_date.to_time.to_i.to_s
end

glue :problem_area do 
	attributes :name => :problem_area
end

glue :status do 
	attributes :name => :current_status
end

#temp Pictures #
node do
	{:pictures => ["#1","#2","#3"]}
end

node :last_review do |request|
	if request.last_reviewed
		request.last_reviewed.to_time.to_i.to_s
	else
		""
	end
end

glue :location do 
	attributes :name => :location_name
end

node :identifier do |request|
	request.id.to_s
end