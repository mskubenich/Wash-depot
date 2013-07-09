class Request < ActiveRecord::Base
  attr_accessible :completed, :creation_date, :description, :importance, :last_reviewed,
  				  :user_id, :status_id, :location_id, :problem_area_id,
            :picture1, :picture2, :picture3

  belongs_to :user
  belongs_to :status
  belongs_to :problem_area
  belongs_to :location

  has_attached_file :picture1,
                    :url  => "/pictures/1/requests/:id/:style/picture1.:extension",
                    :default_url => "/assets/no-photo.jpg",
                    :path => ":rails_root/public/pictures/1/requests/:id/:style/picture1.:extension"
  has_attached_file :picture2,
                    :url  => "/pictures/2/requests/:id/:style/picture2.:extension",
                    :default_url => "/assets/no-photo.jpg",
                    :path => ":rails_root/public/pictures/2/requests/:id/:style/picture2.:extension"
  has_attached_file :picture3,
                    :url  => "/pictures/3/requests/:id/:style/picture3.:extension",
                    :default_url => "/assets/no-photo.jpg",
                    :path => ":rails_root/public/pictures/3/requests/:id/:style/picture3.:extension"

  validate :least_one_picture
  validates :description, :presence => true

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


  private

  def least_one_picture
    errors.add(:pictures, "must be at least one picture.") if !self.picture1.present? && !self.picture2.present? && !self.picture3.present?
  end
end
