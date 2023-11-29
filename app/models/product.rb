class Product < ApplicationRecord
  belongs_to :company
  has_many :feedback_requests, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :product_url, presence: true

  scope :recent, -> { order(created_at: :desc) }

  scope :search, ->(search_query) {
          search_query = search_query.strip
          where("name ILIKE ?", "%#{search_query}%")
        }
end
