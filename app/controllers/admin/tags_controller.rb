class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, only: [:edit, :update, :destroy]

  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "タグ「#{@tag.name}」を作成しました"
    else
      render :new
    end
  end

  def index
    @tags = Tag.all
    @tags = @tags.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "タグを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to admin_tags_path, notice: "タグを削除しました"
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
  
end
