class Product < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :product_url, presence: true
end
