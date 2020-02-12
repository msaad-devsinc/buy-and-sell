class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders
  has_one_attached :image

  validates :firstName, presence: true,length: { maximum: 25 }
  validates :lastName, presence: true,length: { maximum: 25 }
  validates :phone, presence: true,length: { is: 11 },numericality: { only_integer: true }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
