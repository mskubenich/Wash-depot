collection @requests, :object_root => false

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

node :picture1 do |request|
    Base64.encode64(File.binread(request.picture1.path)) if request.picture1_file_size
end

node :picture2 do |request|
    Base64.encode64(File.binread(request.picture2.path)) if request.picture2_file_size
end

node :picture3 do |request|
    Base64.encode64(File.binread(request.picture3.path)) if request.picture3_file_size
end

