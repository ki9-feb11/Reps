class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

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

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :password, :position, :region)
  end
end
