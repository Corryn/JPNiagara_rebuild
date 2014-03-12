class Comment < ActiveRecord::Base
	attr_accessible :name, :email, :message, :tags
	validates :name, :email, :message, presence: true
	validates_format_of :email, :with => /\A([A-Z0-9._%+-]+)@([A-Z0-9.-]+)\.([A-Z]{2,})\z/i
end