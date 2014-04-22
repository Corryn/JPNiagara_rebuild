class Gallery < ActiveRecord::Base
	has_many :pictures
	attr_accessible :name
	validates :name, presence: true
end