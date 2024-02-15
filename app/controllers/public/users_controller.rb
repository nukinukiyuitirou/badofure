class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  def index
    #@users = User.all.page(params[:page]).per(10).order(created_at: :desc)
    @users = User.all.where(is_active: true).page(params[:page]).per(10).order(created_at: :desc)

    if params[:region_id].present? && params[:region_id] != "1"
      @users = Region.find(params[:region_id]).users.page(params[:page]).per(10).order(created_at: :desc)
    end
    if params[:is_sex].present?
      @users = @users.where(is_sex: params[:is_sex]).page(params[:page]).per(10).order(created_at: :desc)
    end
    if params[:level].present?
      @users = @users.where(level: params[:level]).page(params[:page]).per(10).order(created_at: :desc)
    end
    if params[:name].present?
      @users = @users.where(name: params[:name]).page(params[:page]).per(10).order(created_at: :desc)
    end
  end

  def show
    @user = User.find(params[:id])
    @profile_image = @user.profile_image
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
    end
    unless @is_room
      @room = Room.new
      @entry = Entry.new
    end
  end

  def edit

    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end

    @user = User.find(params[:id])
  end

  def update

    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end

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
    @user.update(is_active: false)
    # pp "user2--------------------------------#{@user.inspect}"
    #reset_session
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
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
