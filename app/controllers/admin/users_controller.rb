class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!, except: [:top]
  def index
  end

  def show
  end

  def followings
  end

  def followers
  end
end
