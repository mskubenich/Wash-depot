class Request < ActiveRecord::Base
  attr_accessible :completed, :creation_date, :description, :importance, :last_reviewed,
  				  :user_id, :status_id, :location_id, :problem_area_id,
            :picture1, :picture2, :picture3

  belongs_to :picture1, foreign_key: :picture1_id, class_name: 'Picture'
  belongs_to :picture2, foreign_key: :picture2_id, class_name: 'Picture'
  belongs_to :picture3, foreign_key: :picture3_id, class_name: 'Picture'
  belongs_to :user
  belongs_to :status
  belongs_to :problem_area
  belongs_to :location

  def as_json(options={})

  	{:date => creation_date,
  	 :requested_by => "#{self.user.firstname} #{self.user.lastname}",
  	 :problem_area => self.problem_area.name,
  	 :description => description,
  	 :priority => importance,
  	 :current_status => self.status.name,
  	 :pictures => ["#1, #2, #3"],
  	 :last_review => last_reviewed.to_s,
  	 :location => self.location.name
  	}
  end
end
