class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders
  has_one :image, as: :imagable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
