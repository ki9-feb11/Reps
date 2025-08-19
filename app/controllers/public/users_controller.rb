class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]

  def mypage
    @user = current_user
    @posts = current_user.posts.order(created_at: :desc)
    # @bookmarked_posts = current_user.bookmarked_posts
  end

  def index
    @users = User.all
    
    # 名前検索
    if params[:name].present?
      keyword = "%#{params[:name]}%"
      @users = @users.where('LOWER(last_name) LIKE LOWER(?) OR LOWER(first_name) LIKE LOWER(?)', keyword, keyword)
    end
    
    # 役職検索
    if params[:position].present?
      @users = @users.where(position: params[:position])
    end
    
    # 担当地域検索
    if params[:region].present?
      @users = @users.where(region: params[:region])
    end
    
    @users = @users.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    redirect_to mypage_path, alert: "他のユーザーは編集できません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :position, :region, :profile_image)
  end
end
