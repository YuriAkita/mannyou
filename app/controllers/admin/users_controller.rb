class Admin::UsersController < ApplicationController
  before_action :if_not_admin
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.select(:id, :name, :email, :admin).order(created_at: :desc).includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path,notice:"ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
     redirect_to admin_users_path(@user), notice:"ユーザー「#{@user.name}」を更新しました"
   else
     render :edit
   end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」を削除しました"
  end

  private
  def if_not_admin
    unless current_user.admin?
      redirect_to root_path
      flash[:notice]="管理者以外はアクセスできません"
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confimation)
  end

end
