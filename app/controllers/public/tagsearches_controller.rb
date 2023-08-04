class Public::TagsearchesController < ApplicationController
  before_action :authenticate_customer!
  
  # タグ検索
  def search
    @word = params[:content]
    if @word.empty?
      flash.now[:alert] = "検索ワードを入力してください。"
      @reviews = []
    else
      @reviews = Review.joins(:customer).where("category LIKE?","%#{@word}%").where(customers: { is_deleted: false }).page(params[:page]).per(5)
    end
    render "public/tagsearches/tagsearch"  
  end
  
end