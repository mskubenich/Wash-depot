object @request

attributes :id, :completed

node :desc do |request|
	request.description
end

node :creation_date do |request|
	request.creation_date.to_time.to_i.to_s
end

node :problem_area do |request|
   request.problem_area.name
end

node :status do |request|
	request.status.name
end

node :importance do |request|
	request.importance.name if request.importance
end

node :picture1 do |request|
    Base64.encode64(File.binread(request.picture1.picture.path)) if request.picture1
end

node :picture2 do |request|
    Base64.encode64(File.binread(request.picture2.picture.path)) if request.picture2
end

node :picture3 do |request|
    Base64.encode64(File.binread(request.picture3.picture.path)) if request.picture3
end

child :pictures do
    node :id do |img|
       img.id
    end
    node :body do |img|
       Base64.encode64(File.binread(img.picture.path))
    end
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