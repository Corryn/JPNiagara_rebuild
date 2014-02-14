class Picture < ActiveRecord::Base
	has_many :events
	attr_accessible :picture_description, :picture_file
	validates :picture_description, :picture_file, presence: true
end