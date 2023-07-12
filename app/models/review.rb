class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :book
  
  validates :star, presence: true
  validates :category, presence: true
  validates :impression, presence: true
  validates :action, presence: true
  
end
