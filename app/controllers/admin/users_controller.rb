class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!, except: [:top]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.post
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def followings
  end

  def followers
  end
end
