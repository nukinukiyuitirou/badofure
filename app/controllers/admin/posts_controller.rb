class Admin::PostsController < ApplicationController
 before_action :authenticate_admin!, except: [:top]
  def index
    @posts = Post.all.page(params[:page]).per(10)
    if params[:region_id].present? && params[:region_id] != "1"
      @posts = Region.find(params[:region_id]).posts
    end
    if params[:is_sex].present?
      user_ids = User.where(is_sex: params[:is_sex]).pluck(:id)
      @posts = @posts.where(user_id: user_ids)
    end
    if params[:level].present?
      @posts = @posts.where(level: params[:level])
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
