class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
   @user = User.new(user_create)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def update
    
    if @user.update(user_update)
      flash[:success] = 'ユーザー情報を更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報を更新できませんでした'
      render :edit
    end
  end
  
  private
  
  def user_update
    params.require(:user).permit(:name, :email, :age, :display_gender, :display_age, :display_records)
  end
  
  def user_create
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :age)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
