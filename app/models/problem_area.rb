class ProblemArea < ActiveRecord::Base
  attr_accessible :id, :name

  has_many :requests
end
