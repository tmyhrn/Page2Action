class Public::TagsearchesController < ApplicationController
  
  @model = Review
  @word = params[:content]
  @reviews = Review.where("category LIKE?","%#{@word}%")
  render "public/tagsearches/tagsearch"
end
