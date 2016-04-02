class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user.id)
    else
      flash.now[:errors]
    end
  end

  def update

  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
