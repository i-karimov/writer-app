class PostsController < ApplicationController
  before_action :load_post!, only: %i[show edit update destroy]
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:region).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @regions = Region.all
  end

  def update
    if @post.update(post_params.except(:images, :files)) # TODO: move to form object eventually
      @post.images.attach(post_params[:images]) unless @post.images.attached?
      @post.files.attach(post_params[:files]) unless @post.files.attached?

      flash[:success] = 'Post updated successfully'
      render :show
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @post.destroy

    flash[:success] = 'Post deleted successfully'

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :region_id, images: [], files: [])
  end

  def load_post!
    @post = Post.find(params[:id])
  end
end
