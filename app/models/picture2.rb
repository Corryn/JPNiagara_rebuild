class Picture2 < ActiveRecord::Base
	self.table_name = 'pictures'
	has_many :specials
	attr_accessible :picture_description, :picture_file, :id
end