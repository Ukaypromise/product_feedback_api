class FeedbackRequest < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :comments
  has_many :votes
end
