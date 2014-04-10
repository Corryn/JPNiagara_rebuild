class Picture < ActiveRecord::Base
	has_many :tours
	has_many :events
	belongs_to :facility
	belongs_to :gallery
	attr_accessible :description, :file, :sitetype_id, :gallery_id
	validates :description, :file, presence: true
end