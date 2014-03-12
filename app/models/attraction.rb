class Attraction < ActiveRecord::Base
	belongs_to :content
	attr_accessible :attraction_name, :content_id, :latitude, :longitude, :color, :marker_label
	validates :attraction_name, presence: true
end
