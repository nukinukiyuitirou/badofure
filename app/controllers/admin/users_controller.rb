class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!, except: [:top]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def followings
  end

  def followers
  end
end
