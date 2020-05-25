class GuestSessionsController < SessionsController
  def test
    login('test-user@gmail.com', '2423abc')
    flash[:success] = 'テストユーザーでログインしました'
    redirect_to @user
  end
end
