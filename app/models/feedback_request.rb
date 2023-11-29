class FeedbackRequest < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :comments
  has_many :votes

  validates :title, presence: true, length: { minimum: 10, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
