class Facility < ActiveRecord::Base
	belongs_to :picture
	attr_accessible :name, :description, :picture_id
	validates :name, presence: true
end