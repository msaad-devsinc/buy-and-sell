class Product < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many_attached :images
	belongs_to :user

	validates :title, 
			presence: true,
			length: { maximum: 30 }
	validates :category, 
			presence: true,
			length: { maximum: 15 }
	validates :description, 
			presence: true,
			length: { maximum: 250 }
	validates :price, 
			presence: true,
			numericality: true
	validates :quantity, 
			presence: true,
			numericality: true
end
