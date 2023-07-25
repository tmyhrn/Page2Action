class Public::TagsearchesController < ApplicationController
  before_action :authenticate_customer!
  
  # タグ検索
  def search
    @word = params[:content]
    @reviews = Review.joins(:customer).where("category LIKE?","%#{@word}%").where(customers: { is_deleted: false }).page(params[:page]).per(5)
    render "public/tagsearches/tagsearch"  
  end
  
end