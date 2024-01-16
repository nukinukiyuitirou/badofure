class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!, except: [:top]
  def index
    @users = User.all
    if params[:region_id].present? && params[:region_id] != "1"
      @users = Region.find(params[:region_id]).users
    end
    if params[:is_sex].present?
      @users = @users.where(is_sex: params[:is_sex])
    end
    if params[:level].present?
      @users = @users.where(level: params[:level])
    end
    if params[:name].present?
      @users = @users.where(name: params[:name])
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end
