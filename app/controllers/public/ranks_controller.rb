class Public::RanksController < ApplicationController
  
  def rank
    @review_favorite_ranks = Review.find(Favorite.group(:review_id).order('count(review_id) desc').limit(5).pluck(:review_id))
    @review_review_comment_ranks = Review.find(ReviewComment.group(:review_id).order('count(review_id) desc').limit(5).pluck(:review_id))
  end
  
end
