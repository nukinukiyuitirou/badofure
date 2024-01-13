class Admin::SearchsController < ApplicationController
  before_action :authenticate_admin!, except: [:top]
end
