class Company < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :product_url, presence: true, uniqueness: true
end
