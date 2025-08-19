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
  
    # タグ検索
    if params[:tag_id].present?
      @posts = @posts.joins(:tags).where(tags: { id: params[:tag_id] })
    end

    # タイトル検索
    if params[:title].present?
      @posts = @posts.where("title LIKE ?", "%#{params[:title]}%")
    end
    
    # 名前検索
    if params[:author_last_name].present?
      @posts = @posts.joins(:user).where("users.last_name LIKE ?", "%#{params[:author_last_name]}%")
    end
    
    # 苗字検索
    if params[:author_first_name].present?
      @posts = @posts.joins(:user).where("users.first_name LIKE ?", "%#{params[:author_first_name]}%")
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
