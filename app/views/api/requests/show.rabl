object @request
attributes :creation_date => :date, :description => :description, :importance => :priority

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
	request.last_reviewed.to_s
end

glue :location do 
	attributes :name
end
