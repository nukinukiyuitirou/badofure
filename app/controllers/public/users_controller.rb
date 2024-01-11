class Public::UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:name,:shot,:introduction,:region_id,:is_sex,:level,:profile_image)
  end


end
