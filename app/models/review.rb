class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, presence: true
end
