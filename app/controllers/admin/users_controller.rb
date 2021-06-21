class Admin::UsersController < ApplicationController
  before_action :if_not_admin

  def index
    @users = User.all.order(created_at: :desc)
  end

  private
  def if_not_admin
    redirect_to root_path unless current_user.admin?
    flash[:notice]="管理者以外はアクセスできません"
  end

end
