class Admin::UsersController < ApplicationController
  before_action :if_not_admin

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_user
  end
end
