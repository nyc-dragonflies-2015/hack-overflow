module ApplicationHelper
  def logged_in?
    !!session[:user_id]
  end

  def authenticate_user!(owner_id)
    if current_user != owner_id
      redirect_to root_path, notice: "Access denied"
    end
  end

  def signup_redirect
    if !current_user
      redirect_to new_user_path
    end
  end

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    else
      return nil
    end
  end
end
