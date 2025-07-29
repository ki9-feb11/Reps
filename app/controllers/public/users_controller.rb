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
    if params[:name].present?
      keyword = "%#{params[:name]}%"
      @users = @users.where('last_name LIKE ? OR first_name LIKE ?', keyword, keyword)
    end
    if params[:position].present?
      @users = @users.where(position: params[:position])
    end
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
