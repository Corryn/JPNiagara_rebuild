class Content < ActiveRecord::Base
	belongs_to :picture
	attr_accessible :content_name, :content_text

	#scope :getContent

	def self.getContent(int) 
		self.joins(:picture).where(content_type_id: int)
	end
end