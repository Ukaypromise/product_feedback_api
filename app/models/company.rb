class Company < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :product_url, presence: true, uniqueness: true
end
