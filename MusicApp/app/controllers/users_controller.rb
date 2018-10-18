class UsersController < ApplicationController

  def new
    @user = User.new # <= ?
    render :new
    #tells controller to render the new.html.erb template for users
  end

  def create
    @user = User.new(user_params)

    if @user.save # <= if user passes validations (i.e., enters valid email and password)
    # log-in user! => resets the user's session_token and cookie
      # session[:session_token] = user.reset_session_token!
      log_in_user!(@user)
    # redirect user to where you see fit - usually the user's homepage
      redirect_to user_url(@user.id)
        # user_url takes an argument - the wildcard, user's id
        # which can be accessed with both @user or @user.id
    else # if user does not successfully create an account
      # display errors (e.g., "email can't be blank")
      flash.now[:errors] = @user.errors.full_messages
      # flash.now[:errors] = ['invalid email/password']
      # errors.full_messages is an array of strings, if no errors, then it's an empty [] => nil
      # use flash instead of flash.now when READING errors, flash.now for SETTING

      # re-display new log-in
      render :new
    end
  end

  def show
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
    # permit :email and :password as the parameters required for user to log-in
  end
end
