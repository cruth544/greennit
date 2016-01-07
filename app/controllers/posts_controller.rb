class PostsController < ApplicationController

  def all
    @posts = Post.all.reverse_order
    render :index
  end

  def index
    if current_user
      subgreenit_list = current_user.subgreens
      if subgreenit_list.length > 0
        @posts = []
        subgreenit_list.each do |sub|
          sub.posts.each do |post|
            @posts << post
          end
        end
      else
        @posts = Post.all.reverse_order
    end
    else
      @posts = Post.all.reverse_order
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.reverse_order
  end

  def new
    @post = Post.new
    @subgreen_id = params[:subgreen_id]
  end

  def create
    new_post = Post.new(post_params)

    if current_user
      if new_post.save
        # current_user.posts << new_post
        # sub_id = new_post.subgreen_id
        # subgreenit = Subgreen.find(sub_id)
        # subgreenit.posts << new_post
        redirect_to post_path(new_post)
      else
        raise "Error"
      end
    else
      raise "Please log in to post"
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(@post)
    end

    updated_post = @post
    updated_post.update_attributes(post_params)
    if is_valid?(updated_post)
      if @post.update_attributes(post_params)
        return redirect_to post_path(@post)
      end
    end
    render :edit
  end

  def upvote
    raise
    @post = Post.find(params[:id])
    @post.up_vote += 1
    render post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :subgreen_id, :url_link, :body)
  end

  def is_valid? post
    if post.title != ""
      if post.url_link != "" or post.text != ""
        return true
      end
    end
    return false
  end

end
