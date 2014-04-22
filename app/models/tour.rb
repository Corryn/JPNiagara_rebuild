class Tour < ActiveRecord::Base
	attr_accessible :name, :picture_id, :description, :coupon_desc, :color
	validates :name, :description, :color, presence: true
	has_many :contents
	belongs_to :picture
end