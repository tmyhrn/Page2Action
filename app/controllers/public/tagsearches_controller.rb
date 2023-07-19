class Public::TagsearchesController < ApplicationController
  before_action :authenticate_customer!
  
  def search
    @word = params[:content]
    @reviews = Review.where("category LIKE?","%#{@word}%")
    render "public/tagsearches/tagsearch"  
  end
  
end
