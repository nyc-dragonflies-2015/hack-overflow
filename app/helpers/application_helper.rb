module ApplicationHelper
  def require_logged_in
    redirect_to root_path unless is_authenticated?
  end

  def is_authenticated?
    return !!session[:user_id]
  end

  def current_user
    @user = User.find(session[:user_id])
  end
end
