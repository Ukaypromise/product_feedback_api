class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :feedback_request
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment', optional: true

  validates :body, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :user_id, presence: true
end
