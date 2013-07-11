class Importance < ActiveRecord::Base
  has_many :importances
  attr_accessible :name
  validates :name, presence: true, uniqueness: true
end
