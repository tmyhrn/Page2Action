class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:success] = "会員情報が更新されました。"
      redirect_to customer_path
    else
      flash.now[:danger] = "未記入項目があります。"
      render :edit
    end
  end
  
  def check
    
  end
  
  def withdrawal
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:danger] = "退会処理を実行しました"
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:nickname, :email, :is_deleted)
  end
  
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
  
end
