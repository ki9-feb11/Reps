class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @customers = Customer.all
    #ページネーション
    @customers = @customers.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer =  Customer.find(params[:id])
    if @customer.update(user_customer_params)
      redirect_to public_customer_path(@customer), notice: "顧客情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def user_customer_params
    params.require(:customer).permit(:contact_person, :key_parson, :notes)
  end

end
