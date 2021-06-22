class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: 'ログインしました！'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.id != @current_user.id
      flash[:notice]="権限がありません"
      redirect_to tasks_path
    end
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
