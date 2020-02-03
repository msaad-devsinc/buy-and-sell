class Product < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many_attached :images
	# has_many :images, as: :imagable
	belongs_to :user
end
