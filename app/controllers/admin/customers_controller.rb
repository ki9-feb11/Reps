class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
    #ページネーション
    @customers = @customers.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @cuntomer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to admin_customer_path(@customer), notice: "顧客を新規登録しました。"
    else
      render :new
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer =  Customer.find(params[:id])
    if @customer.update(admin_customer_params)
      redirect_to admin_customer_path(@customer), notice: "顧客情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def admin_customer_params
    params.require(:customer).permit(:name, :address, :industry, :contact_person, :key_parson, :notes)
  end
end
