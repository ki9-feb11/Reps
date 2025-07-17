class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = current_user.posts.new
    @customers = Customer.all
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: "投稿を作成しました。"
    else
      @customers = Customer.all
      render :new
    end
  end

  def index
    @posts = current_user.posts.includes(:tags, :products).order(created_at: :desc)

    #ページネーション
    @posts = @posts.page(params[:page]).per(10)
  end

  def show
  end

  def edit
    @customers = Customer.all
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      @customers = Customer.all
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def set_post
    @post = current_user.posts.find(prams[:id])
  end

  def post_params
    params.require(:post).permit(
      :title, :body, :status, :result_status, :reaction, :result_notes,
      :customer_id, :product_id, :quantity)
  end

end
