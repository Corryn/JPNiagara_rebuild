class CalendarEvent < ActiveRecord::Base
	belongs_to :picture
	attr_accessible :name, :tag, :text, :picture_id, :link, :start_date, :end_date
	validates :name, :tag, :text, :start_date, :end_date, presence: true

	def self.getCurrMonth(startOfMonth,endOfMonth)
		x = "'#{startOfMonth}' AND '#{endOfMonth}'"
		puts "Are we here yet!?"
		self.joins("LEFT JOIN pictures ON calendar_events.picture_id = pictures.id WHERE start_date BETWEEN #{x} OR end_date BETWEEN #{x}").order(:start_date);
	end

end
