class Admin::PostsController < ApplicationController
 before_action :authenticate_admin!, except: [:top]
  def index
    @posts = Post.all.page(params[:page]).per(9).order(created_at: :desc)
    if params[:region_id].present? && params[:region_id] != "1"
      @posts = Region.find(params[:region_id]).posts.page(params[:page]).per(9).order(created_at: :desc)
    end
    if params[:is_sex].present?
      user_ids = User.where(is_sex: params[:is_sex]).pluck(:id)
      @posts = @posts.where(user_id: user_ids).page(params[:page]).per(9).order(created_at: :desc)
    end
    if params[:level].present?
      @posts = @posts.where(level: params[:level]).page(params[:page]).per(9).order(created_at: :desc)
    end
  end

  def show
     @post = Post.find(params[:id])
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
