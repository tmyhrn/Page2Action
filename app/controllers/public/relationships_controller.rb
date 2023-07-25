class Public::RelationshipsController < ApplicationController
  
  # フォローするとき
  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end
  
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer  
  end
  
  # フォローしている会員を取得
  def following
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end

  # フォロー
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
end
