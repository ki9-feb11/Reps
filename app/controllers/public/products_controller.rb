class Public::ProductsController < ApplicationController

  def index
    @products = Product.all.order(:name, :manufacturer, :category)
    @products = Product.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
