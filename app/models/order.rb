class Order < ApplicationRecord
	belongs_to :user

	validates :total,presence: true,numericality: true

  def self.update_inventory(cart)
    products = Product.find(cart['products'].keys)
    products.each do |product|
      quantity = cart['products'][product.id.to_s]
      product.quantity = product.quantity - quantity.to_i
      product.save
    end

  end
end
