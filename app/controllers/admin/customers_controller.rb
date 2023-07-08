class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_user, only: [:edit]
  
  def index
    @customers = Customer.page(params[:id]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] ="#{@customer.nickname}さんの会員情報が更新されました。"
      redirect_to admin_customer_path(params[:id])
    else
      flash.now[:danger] = "未記入項目があります。"
      render :edit
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:nickname, :introduction, :profile_image, :email, :is_deleted)
  end
  
end
