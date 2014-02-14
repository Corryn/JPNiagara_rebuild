class ContentType < ActiveRecord::Base
	attr_accessible :content_name
	validates :content_name, presence: true
end