class Product < ApplicationRecord
    has_one_attached :image
  
    validates :name, :price, :description, presence: true
    has_many :cart_items, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :order_items, dependent: :destroy
end