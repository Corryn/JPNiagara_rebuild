class Content < ActiveRecord::Base
	belongs_to :picture
	attr_accessible :content_name, :content_type_id, :picture_id, :content_text
	validates :content_name, :content_type_id, :content_text, presence: true

	#scope :getContent

	def self.getContent(int) 
		self.joins('LEFT JOIN pictures ON contents.picture_id = pictures.id').where(content_type_id: int)
	end
end