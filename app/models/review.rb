class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :book
  has_many :review_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :star, presence: true
  validates :category, presence: true
  validates :impression, presence: true
  validates :action, presence: true
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
end
