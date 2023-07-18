class Public::TagsearchesController < ApplicationController
  
  def search
    @word = params[:content]
    @reviews = Review.where("category LIKE?","%#{@word}%")
    render "public/tagsearches/tagsearch"  
  end
  
end
