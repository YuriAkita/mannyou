class UsersController < ApplicationController
<<<<<<< Updated upstream
  skip_before_action :login_required, only: [:new, :create]

=======
>>>>>>> Stashed changes
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
<<<<<<< Updated upstream
      redirect_to user_path(@user.id)
=======
>>>>>>> Stashed changes
    else
      render :new
    end
  end

  def show
<<<<<<< Updated upstream
    @user = User.find(params[:id])
=======
>>>>>>> Stashed changes
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
