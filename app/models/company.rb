class Company < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  scope :recent, -> { order(created_at: :desc) }

  # scope :search, ->(search_query) {
  #         search_query = search_query.strip
  #         where("name ILIKE ?", "%#{search_query}%")
  #       }
  scope :search, ->(search_query) {
          search_query = search_query.strip
          where("name LIKE :search", search: "%#{search_query}%")
        }
end
