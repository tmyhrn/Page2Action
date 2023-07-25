class Public::FavoritesController < ApplicationController
  
  # いいねする機能
  def create
    @review = Review.find(params[:review_id])
    favorite = current_customer.favorites.new(review_id: @review.id)
    favorite.save
  end

  # いいねを解除する機能
  def destroy
    @review = Review.find(params[:review_id])
    favorite = current_customer.favorites.find_by(review_id: @review.id)
    favorite.destroy
  end
  
end
