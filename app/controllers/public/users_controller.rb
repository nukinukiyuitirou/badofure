class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
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
    #byebug
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

  def unsubscribe
    @user = current_user

  end

  def withdraw
    @user = User.find(params[:user_id])
    pp "params------------#{params}"
    pp "user--------------------------------#{@user.inspect}"
    @user.update(is_active: false)
    # pp "user2--------------------------------#{@user.inspect}"
    #reset_session
    #redirect_to root_path
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
