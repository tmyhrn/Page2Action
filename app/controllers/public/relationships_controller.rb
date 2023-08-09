class Public::RelationshipsController < ApplicationController
  
  # フォローするとき
  def create
    current_customer.follow(params[:customer_id])
    flash[:success] = "フォローしました！"
    redirect_to request.referer
  end
  
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    flash[:success] = "フォローを解除しました。"
    redirect_to request.referer
  end
  
  # フォローしている会員を取得・表示
  def following
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followings.where(is_deleted: false).page(params[:page]).per(3)
  end

  # フォロワー会員を取得・表示
  def followers
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followers.where(is_deleted: false).page(params[:page]).per(3) 
  end
end
