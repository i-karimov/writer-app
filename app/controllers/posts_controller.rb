class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params.except(:images, :files)) # TODO: move to form object eventually
      @post.images.attach(post_params[:images]) unless @post.images.attached?
      @post.files.attach(post_params[:files]) unless @post.files.attached?

      flash[:success] = 'Post updated successfully'
      redirect_to posts_path
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    flash[:success] = 'Post deleted successfully'

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, images: [], files: [])
  end
end
