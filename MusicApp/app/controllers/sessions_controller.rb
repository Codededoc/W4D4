class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])

    if @user
      # session[:session_token] = user.reset_session_token!
      log_in_user!(@user)
      # if user's credentials match, log-in user
      redirect_to user_url(@user.id)
      # user_url takes an argument - the wildcard, user's id
      # which can be accessed with both @user or @user.id
    else
      flash.now[:errors] = ['invalid email/password']
      # @user.errors.full_messages
            # errors.full_messages is an array of strings = [] => nil
      # use flash instead of flash.now when READING errors, flash.now for SETTING

      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url #<= this is flexible, where you want to direct the user after they log out
  end
end
