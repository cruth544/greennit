class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    new_comment = Comment.new(comment_params)

    if current_user
      if new_comment.save
        current_user.comments << new_comment
        redirect_to post_path(comment_params[:post_id])
      else
        raise "Commenting Error"
      end
    else
      raise "Please log in to comment"
    end
  end

  def edit
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
