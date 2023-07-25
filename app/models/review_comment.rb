class ReviewComment < ApplicationRecord
  belongs_to :customer
  belongs_to :review
end
