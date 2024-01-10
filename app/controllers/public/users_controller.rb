class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def confirm
  end
  
  def unsubscribe
  end
  
  def favorites
  end
  
  private

  def user_params
    params.require(:user).permit(:name)
  end

  
end
