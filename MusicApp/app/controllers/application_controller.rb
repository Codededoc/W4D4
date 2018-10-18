class ApplicationController < ActionController::Base

  # C => current_user
  # E => ensure_logged_in
  # L => log_in_user!(user)
  # L => log_out
  # L => logged_in?

  #gives view files access to the helper_methods
    helper_method :current_user
    helper_method :logged_in?

  def current_user
    # return nil if there's no session_token => no current user
    return nil unless session[:session_token]

    # return current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
    # @current_user || @current_user =  User.find_by(session_token: session[:session_token])

    #User.find_by is a class method that allows you to search by key-value pair

    #@current_user sets current_user to the user that is found from the session_token,
    # which now provides access to current_user in other methods and views (through helper methods)

  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
    # what we want here is to ensure that if user is logged in, they're using the same
    # session token
    # if not logged in, redirect to new_session_token
  end

  def log_in_user!(user)
    # resets the user's session token and cookie
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    # for user-experience, user's session_token is reset when logging out
    current_user.reset_session_token!

    # set the current session_token to nil
    session[:session_token] = nil
    # redirect_to new_session_url

  end

  def logged_in? #return a boolean that indicates whether there is a current_user
    #current_user <= change this to a boolean
    !!current_user # <= the !! allows you to return false if current_user is nil
  end

end
