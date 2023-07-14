class Review < ApplicationRecord
  
  #アソシエーション
  belongs_to :customer
  belongs_to :book
  has_many :review_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #バリデーション
  validates :star, presence: true
  validates :category, presence: true
  validates :impression, presence: true
  validates :action, presence: true
  
  #いいね機能
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
  #ソート機能
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  
end
