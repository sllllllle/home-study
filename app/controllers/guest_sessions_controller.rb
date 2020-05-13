class GuestSessionsController < SessionsController
  # skip_before_action :login_required
  
  def suenaga
    login("suenaga@gmail.com", "2423abc")
    flash[:success] = "'suenaga'でログインしました"
    redirect_to @user
  end
  
  def katsuyuki
    login("katsuyuki@gmail.com", "2423abc")
    flash[:success] = "'katsuyuki'でログインしました"
    redirect_to @user
  end
end
