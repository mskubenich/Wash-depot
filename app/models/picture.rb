class Picture < ActiveRecord::Base
  attr_accessible :request_id, :picture
  has_attached_file :picture,
                    :url  => "/images/pictures/pictures/:id/:basename.:extension",
                    #:default_url => "/assets/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/ads/:id/:basename.:extension"
  belongs_to :request
end
