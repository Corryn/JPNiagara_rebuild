class Special < ActiveRecord::Base
	belongs_to :pictures
	attr_accessible :special_name, :special_description, :link_id, :view_id, :special_start_date, :special_end_date
	validates :special_name, :special_description, :special_start_date, :special_end_date, presence: true

	def self.getCurrentSpecials(date)
		@specials = ActiveRecord::Base.connection.execute("SELECT specials.*, p1.picture_file, p2.picture_file FROM specials LEFT JOIN pictures p1 ON specials.link_id=p1.id LEFT JOIN pictures p2 ON specials.view_id=p2.id WHERE '#{date}' BETWEEN specials.special_start_date AND specials.special_end_date")
	end
end