class Picture < ActiveRecord::Base
	has_many :contents
	has_many :events
	attr_accessible :picture_description, :picture_file, :id
end