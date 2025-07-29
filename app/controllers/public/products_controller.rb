class Public::ProductsController < ApplicationController

  def index
    @products = Product.all.order(:name, :manufacturer, :category)
  end

  def show
    @product = Product.find(params[:id])
  end
end
