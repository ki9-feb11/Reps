class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.order(:name, :manufacturer, :category)
    @products = @products.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "商品を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "商品情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "商品を削除しました。"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :manufacturer, :category, :list_price, :wholesale_price, :cost_price)
  end
end
