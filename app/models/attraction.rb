class Attraction < ActiveRecord::Base
	belongs_to :content
	attr_accessible :name, :content_id, :latitude, :longitude, :color, :marker_label
	validates :name, presence: true
end
