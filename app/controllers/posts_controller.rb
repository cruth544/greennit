class PostsController < ApplicationController

  def all
    @posts = Post.all.reverse_order
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
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
        @posts = Post.all
      end
    else
      @posts = Post.all
    end
    @posts = @posts.sort_by &:created_at
    @posts.reverse!
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.reverse_order
    @subgreen = Subgreen.find(@post.subgreen.id)
  end

  def new
    @post = Post.new
    @subgreen_id = params[:subgreen_id]
    @subgreen = Subgreen.find(@subgreen_id)
    unless @subgreen_id
      redirect_to root_path
    end
    unless current_user
      flash[:error] = "You must be logged in to post"
      redirect_to root_path
    end
    @post.title = params[:title]
    @post.url_link = params[:url_link]
    @post.body = params[:body]
  end

  def create
    new_post = Post.new(post_params)
    new_post.title = new_post.title.split.map(&:capitalize).join(' ')
    unless is_valid?(new_post)
      redirect_to new_post_path(:subgreen_id => post_params[:subgreen_id], title: new_post.title, url_link: new_post.url_link, body: new_post.body)
      return
    end

    if current_user
      if new_post.save
        current_user.posts << new_post
        redirect_to post_path(new_post)
      else
        raise "Error saving post"
      end
    else
      flash[:error] = "You must be logged in to post"
      if new_post.subgreen
        return redirect_to subgreen_path(Subgreen.find(new_post.subgreen))
      end
      return redirect_to root_path
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subgreen_id = @post.subgreen_id
    @subgreen = Subgreen.find(@subgreen_id)
    unless @post.user == current_user
      flash[:error] = "You must be the creator in order to edit this post"
      return redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.title = @post.title.split.map(&:capitalize).join(' ')
    unless @post.user == current_user
      flash[:error] = "You must be the creator in order to edit this post"
      return redirect_to post_path(@post)
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
      error = "Your post needs a title"
      if post.url_link != "" or post.body != ""
        error += " and a URL or body"
        return true
      end
    end
    flash[:error] = "A post needs a Title and a URL or body"
    return false
  end

end
