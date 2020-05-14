class GuestSessionsController < SessionsController
  
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
