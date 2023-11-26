class Product < ApplicationRecord
  belongs_to :company
  has_many :feedback_requests, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :product_url, presence: true
end
