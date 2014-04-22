class Content < ActiveRecord::Base
	has_many :attractions
	belongs_to :picture
	belongs_to :tour
	attr_accessible :name, :subheader, :content_type_id, :picture_id, :text, :link, :link_text, :tour_id
	validates :name, :content_type_id, :text, presence: true
	before_create :remove_blanks
	#scope :getContent

	def remove_blanks
		if self[:link_text] == ""
			self[:link_text] = "More Info"
		end
	end

	def self.getContent(int) 
		self.where(content_type_id: int)
	end
end