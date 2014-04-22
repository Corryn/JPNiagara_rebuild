class Resource < ActiveRecord::Base
	has_many :specials
	attr_accessible :description, :use, :path
	validates :use, :path, presence: true
end