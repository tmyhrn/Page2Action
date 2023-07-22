class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @customers = Customer.page(params[:page]).per(4)
  end

  def show
    @customer = Customer.find(params[:id])
    @book = Book.find_by_isbn(params[:isbn] || @isbn)
    @reviews = @customer.reviews.page(params[:page]).per(3)
    @review = Review.find_by(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer = current_customer
      render "edit"
    else
      redirect_to customers_path
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "会員情報が更新されました。"
      redirect_to customer_path(@customer)
    else
      flash.now[:danger] = "未記入項目があります。"
      render :edit
    end
  end

  def check
    @customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    flash[:danger] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :introduction, :profile_image, :email, :is_deleted)
  end
  
  #他人のプロフィールを編集できないようにする
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
  
  #ゲストがプロフィール画面を編集できないように
  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.email == "guest@example.com"
      redirect_to customer_path(current_customer) , alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
