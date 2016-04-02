class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    unless @user.nil?
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["invalid username/pasword"]
      render :new
    end
  end

  def destroy
    logout!(current_user)
    redirect_to new_session_url
  end


end
