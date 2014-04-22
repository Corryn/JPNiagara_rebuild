class Special < ActiveRecord::Base
	belongs_to :picture
	belongs_to :resource
	attr_accessible :name, :description, :link_id, :view_id, :start_date, :end_date, :resource_id
	validates :name, :start_date, :end_date, presence: true

	def self.getCurrentSpecials(date)
		# @specials = ActiveRecord::Base.connection.execute("SELECT specials.*, p1.file, p2.file FROM specials LEFT JOIN pictures p1 ON specials.link_id=p1.id LEFT JOIN pictures p2 ON specials.view_id=p2.id WHERE '#{date}' BETWEEN specials.start_date AND specials.end_date")
		@specials = self.where("'#{date}' BETWEEN specials.start_date AND specials.end_date")
	end
end