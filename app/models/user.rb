class User < ApplicationRecord
  has_secure_password
  has_one :cart, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def admin?
    self.admin == true
  end
end
