class PostsController < ApplicationController
  before_action :set_post!, only: %i[show edit update destroy]
  before_action :require_authentication
  before_action :authorize_post!
  after_action :verify_authorized

  def index
    @q = Post.ransack(params[:q])
    @posts = policy_scope(@q.result.includes(%i[region user])).page(params[:page])

    respond_to do |format|
      format.html {}

      format.zip do
        compressed_filestream = ExportPostsService.call(@posts.pluck(:id))
        send_data compressed_filestream.read, filename: 'posts.zip'
      end
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params

    @post.region = current_user.region if current_user.regular_role?

    if current_user.admin_role?
      @post.status = :approved
      @post.published_at = Time.current
    end

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
    form = PostForm.new(post: @post, params: post_params)
    if form.update
      flash[:success] = 'Post updated successfully'
      redirect_to posts_path
    else
      flash[:danger] = form.errors.full_messages.join(', ')
      redirect_to edit_post_path(@post)
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
    params.require(:post).permit(
      :title,
      :content,
      :status, # TODO: ensure if regular user wouldnt be able to pass :status
      :lock_version,
      :region_id,
      images: [],
      files: []
    )
  end

  def set_post!
    @post = Post.find(params[:id])
  end

  def authorize_post!
    authorize(@post || Post)
  end
end
