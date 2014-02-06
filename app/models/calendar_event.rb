class CalendarEvent < ActiveRecord::Base
	belongs_to :picture
	attr_accessible :event_name, :event_tag, :event_text, :event_link, :event_start_date, :event_end_date

	def self.getCurrMonth(startOfMonth,endOfMonth)
		x = "'#{startOfMonth}' AND '#{endOfMonth}'"
		puts "Are we here yet!?"
		self.joins("LEFT JOIN pictures ON calendar_events.picture_id = pictures.id WHERE event_start_date BETWEEN #{x} OR event_end_date BETWEEN #{x}").order(:event_start_date);
	end
end
