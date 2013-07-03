class Picture < ActiveRecord::Base
  attr_accessible :picture, :request
  has_attached_file :picture,
                    :url  => "/images/pictures/pictures/:id/:basename.:extension",
                    #:default_url => "/assets/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/ads/:id/:basename.:extension"
  has_one :request, foreign_key: :picture1_id
  has_one :request, foreign_key: :picture2_id
  has_one :request, foreign_key: :picture3_id
end
