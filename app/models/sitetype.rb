class Sitetype < ActiveRecord::Base
	has_many :pictures
	attr_accessible :name, :desc_short, :desc_long, :inseason_weekday, :inseason_weekend, :inseason_weekly, :holiday, :offseason_weekday, :offseason_weekend, :offseason_weekly, :rewards_tier, :suitability, :notes
	validates :name, presence: true
end