class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :feedback_request
end
