class Public::ReviewCommentsController < ApplicationController
  
  def create
    review = Review.find(params[:review_id])
    comment = current_customer.review_comments.new(review_params)
    comment.review_id = review.id
    comment.save
    flash[:success] = "コメントを投稿しました！"
    redirect_to review_path(review)
  end
  
  def destroy
    ReviewComment.find(params[:id]).destroy
    flash[:success] = "コメントを削除しました！"
    redirect_to review_path(params[:review_id])
  end
  
  private
  
  def review_params
    params.require(:review_comment).permit(:comment)
  end
end
