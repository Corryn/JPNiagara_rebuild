class Content < ActiveRecord::Base
	has_many :attractions
	belongs_to :picture
	attr_accessible :content_name, :content_type_id, :picture_id, :content_text, :content_link, :content_linktext
	validates :content_name, :content_type_id, :content_text, presence: true
	before_create :remove_blanks
	#scope :getContent

	def remove_blanks
		if self[:content_linktext] == ""
			self[:content_linktext] = "More Info"
		end
	end

	def self.getContent(int) 
		self.where(content_type_id: int)
	end
end