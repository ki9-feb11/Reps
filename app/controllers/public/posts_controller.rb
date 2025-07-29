class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = current_user.posts.new
    @customers = Customer.all
    @tags = Tag.all
    3.times { @post.post_products.new }
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: "投稿を作成しました。"
    else
      @customers = Customer.all
      @tags = Tag.all
      render :new
    end
  end

  def index
    @posts = current_user.posts.includes(:products, :tags).order(created_at: :desc)

    # キーワード検索
    if params[:keyword].present?
      @posts = @posts.where('title LIKE ? OR body LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
  
    # タグ検索
    if params[:tag_id].present?
      @posts = @posts.joins(:tags).where(tags: { id: params[:tag_id] })
    end

    #ページネーション
    @posts = @posts.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @customers = Customer.all
    @tags = Tag.all
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      @customers = Customer.all
      @tags = Tag.all
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title, :body, :status, :result_status, :reaction, :result_notes,
      :customer_id, :product_id, :quantity, tag_ids: [])
  end
end
