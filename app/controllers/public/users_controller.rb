class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def confirm
  end

  def unsubscribe
  end

  def favorites
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:shot,:introduction,:region_id,:is_sex,:level,:profile_image)
  end


end
