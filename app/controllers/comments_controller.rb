class CommentsController < ApplicationController
  def index
  end

  def show
    # @comment = Comment.new
    # @comment_to_append = Comment.find(params[:id])
    comment = Comment.find(params[:id])
    if comment
      redirect_to post_path(comment.post)
    else
      redirect_to root_path
    end
  end

  def new
    @comment = Comment.new
    unless params[:format]
      redirect_to root_path
    end
  end

  def create
    new_comment = Comment.new(comment_params)
    unless is_valid?(new_comment)
      if params[:controller] == "posts"
        return redirect_to post_path(comment_params[:post_id])
      else
        return redirect_to new_comment_path(Comment.find(comment_params[:comment_id]))
      end
    end

    if current_user
      if new_comment[:body].include?("http")
        http_array = new_comment[:body].split(" ")
        http_array.each do |str|
          if str.include?("http")
            @http_str = str
            http_array.delete(str)
          end
        end
        new_comment[:body] = http_array.join(" ")
        new_comment[:picture] = @http_str
      end

      if new_comment[:comment_id]
        parent_comment = Comment.find(new_comment[:comment_id])
        new_comment[:post_id] = parent_comment[:post_id]
      end

      if new_comment.save
        current_user.comments << new_comment
        redirect_to post_path(new_comment[:post_id])
      else
        raise "Commenting Error"
      end
    else
      raise "Please log in to comment"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      binding.pry
      redirect_to post_path(comment_params[:post_id])
    end
  end

  def update
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      redirect_to post_path(@comment.post_id)
    end

    updated_comment = @comment
    updated_comment.update_attributes(update_params)
    if is_valid?(updated_comment)
      if @comment.update_attributes(update_params)
        return redirect_to post_path(@comment.post_id)
      end
    end
    render :edit
  end

  def destroy
    @comment = Comment.find(params[:id])
    post_to_return = @comment.post_id

    if @comment.update_attributes(delete_comment)
      return redirect_to post_path(post_to_return)
    else
      raise "Comment not deleted"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id, :comment_id)
  end

  def update_params
    params.require(:comment).permit(:body)
  end

  def delete_comment
    delete_params = {
      body: "DELETED",
      user_id: nil
    }
  end

  def is_valid? comment
    if comment.body != ""
      return true
    end
    flash[:error] = "Comment cannot be empty"
    return false
  end
end
