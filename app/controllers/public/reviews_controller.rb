class Public::ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book = Book.find_by_isbn(params[:isbn] || @isbn)
  end

  def create
    @book = Book.find(params[:review][:book_id])
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    if @review.save
      flash[:success] = "レビューが作成されました！"
      redirect_to customer_path(current_customer)
    else
      @isbn = params[:isbn]
      render :new
    end
  end

  def index
    @reviews = Review.all
    @book = Book.find_by_isbn(params[:isbn] || @isbn)

  end

  def show
    @review = Review.find(params[:id])
    @book = Book.find_by_isbn(params[:isbn] || @isbn)
  end

  def edit
    @review = Review.find(params[:id])
    @book = Book.find_by_isbn(params[:isbn] || @isbn)
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:success] = "レビューを更新しました！"
      redirect_to reviews_path
    else
      flash[:danger] = "レビューの更新が失敗しました！"
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:success] = "レビューを削除しました！"
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:customer_id, :book_id, :star, :impression, :action)
  end

end