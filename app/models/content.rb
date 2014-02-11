class Content < ActiveRecord::Base
	belongs_to :picture
	attr_accessible :content_name, :content_text

	#scope :getContent

	def self.getContent(int) 
		self.joins('LEFT JOIN pictures ON contents.picture_id = pictures.id').where(content_type_id: int)
	end
end