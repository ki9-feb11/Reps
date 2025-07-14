class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  # 管理者か確認
  before_action :ensure_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path,
        notice: "ユーザー #{@user.email}が作成されました。 パスワード: #{@user.password}"
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: 'ユーザー #{@user.email}が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
  end

  private

  def ensure_admin
    unless current_admin
      redirect_to root_path, alert: '管理者としてログインしてください'
    end
  end

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :password, :position, :region)
  end
end
