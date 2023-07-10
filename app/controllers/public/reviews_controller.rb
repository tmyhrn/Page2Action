class Public::ReviewsController < ApplicationController
  
  def new
    @review = Review.new
    @book = Book.find_by(params[:id])
  end
  
  def create
    @book = Book.find_by(params[:id])
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "レビューが作成されました！"
      redirect_to customers_path
    else
      render :new
    end
  end

  def index
    
  end

  def show
    
  end

  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
  def review_params
    params.require(:review).permit(:customer_id, :book_id, :star, :impression, :action)
  end
  
end
