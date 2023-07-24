class Public::RanksController < ApplicationController
  
  #いいね数とコメント数でランキング表示
  def rank
    @review_favorite_ranks = Review.joins(:customer).where(customers: { is_deleted: false }).joins(:favorites).group(:id).order('count(favorites.id) desc').limit(5)
    @review_review_comment_ranks = Review.joins(:customer).where(customers: { is_deleted: false }).joins(:review_comments).group(:id).order('count(review_comments.id) desc').limit(5)
  end
  
end
