class Product < ApplicationRecord\
	has_many :comments, dependent: :destroy
	has_many :images, as: :imagable
end
