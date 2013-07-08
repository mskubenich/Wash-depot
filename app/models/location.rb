class Location < ActiveRecord::Base
  attr_accessible :id, :name

  has_many :requests

  validates :name, presence: true, uniqueness: true
end
