class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    @@post_to_comment = @post
  end

  def new
    @post = Post.new
  end

  def create
    new_post = Post.new(post_params)

    if current_user
      if new_post.save
        current_user.posts << new_post
        redirect_to post_path(new_post)
      else
        raise "Error"
      end
    else
      raise "Please log in to post"
    end
  end

  def edit
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :url_link, :body)
  end
end
