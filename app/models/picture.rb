class Picture < ActiveRecord::Base
  attr_accessible :request_id
  
  belongs_to :request
end
