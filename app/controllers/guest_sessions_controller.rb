class GuestSessionsController < SessionsController
  # skip_before_action :login_required
  
  def sue
    login("lac85at@gmail.com", "2423abc")
    flash[:success] = "'sue'でログインしました"
    redirect_to @user
  end
  
  def taro
    login("lac8afaat@gmail.com", "2423abc")
    flash[:success] = "'taro'でログインしました"
    redirect_to @user
  end
end
