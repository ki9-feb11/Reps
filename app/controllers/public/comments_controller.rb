class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render 'create_error' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment_id = @comment.id
    if @comment.user == current_user
      @comment.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
