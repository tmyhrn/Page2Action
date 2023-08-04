class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer_review, only: [:edit, :update, :destroy]
  before_action :ensure_active_customer, only: [:show, :edit, :update, :destroy]

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
      flash[:danger] = "未記入項目があります！"
      render :new
    end
  end

  def index
    @book = Book.find_by_isbn(params[:isbn] || @isbn)
    
    if params[:star].present?
      @reviews = Review.joins(:customer).where(customers: { is_deleted: false }, star: params[:star]).page(params[:page]).per(4)
    elsif params[:latest]
      @reviews = Review.joins(:customer).where(customers: { is_deleted: false }).latest.page(params[:page]).per(4)
    elsif params[:old]
      @reviews = Review.joins(:customer).where(customers: { is_deleted: false }).old.page(params[:page]).per(4)
    elsif params[:star_count]
      @reviews = Review.joins(:customer).where(customers: { is_deleted: false }).star_count.page(params[:page]).per(4)
    else
      @reviews = Review.joins(:customer).where(customers: { is_deleted: false }).order(created_at: :desc).page(params[:page]).per(4)
    end
  end

  def show
    @review = Review.find(params[:id])
    @book = Book.find_by_isbn(params[:isbn] || @isbn)
    @review_comment = ReviewComment.new
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
      flash[:danger] = "未記入項目があります！"
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
    params.require(:review).permit(:customer_id, :book_id, :star, :category, :impression, :action)
  end

  #他の人がレビュー編集できないようにする
  def ensure_correct_customer_review
    @review = Review.find(params[:id])
    unless @review.customer == current_customer
      flash[:alert] = "他の会員様のレビュー編集はできません！"
      redirect_to review_path(@review)
    end
  end
  
  #退会済の会員の投稿を見られないようにする
  def ensure_active_customer
    @review = Review.find(params[:id])
    if @review.customer.is_deleted?
      flash[:alert] = "退会済の方の投稿は見ることができません！"
      redirect_to reviews_path
    end
  end

end
