class Public::TagsearchesController < ApplicationController
  before_action :authenticate_customer!
  
  def search
    @word = params[:content]
    @reviews = Review.where("category LIKE?","%#{@word}%").page(params[:page]).per(5)
    render "public/tagsearches/tagsearch"  
  end
  
end