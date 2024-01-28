class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.active_posts.page(params[:page]).per(9).order(created_at: :desc)
    if params[:region_id].present? && params[:region_id] != "1"
      @posts = Region.find(params[:region_id]).posts.active_posts.page(params[:page]).per(9).order(created_at: :desc)
    end
    if params[:is_sex].present?
      user_ids = User.where(is_sex: params[:is_sex]).pluck(:id)
      @posts = @posts.where(user_id: user_ids).page(params[:page]).per(9).order(created_at: :desc)
    end
    if params[:level].present?
      @posts = @posts.where(level: params[:level]).page(params[:page]).per(9).order(created_at: :desc)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end

  def update
     @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:name,:text, :level, :region_id)
  end

end
