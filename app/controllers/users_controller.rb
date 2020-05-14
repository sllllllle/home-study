class UsersController < ApplicationController
  before_action :set_user, only: [
    :show, 
    :edit, 
    :update, 
    :edit_password, 
    :update_password,
    :followings, 
    :followers, 
    :likes, 
    :records
    ]
  before_action :set_count, only: [:show, :likes, :records]
  before_action :require_user_logged_in, only: [:show]
  
  
  def show
    @microposts = @user.microposts.order(id: :desc)
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
    if @user.update_attributes(user_update)
      flash[:success] = 'ユーザー情報を更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報を更新できませんでした'
      render :edit
    end
  end
  
  def followings
    @followings = @user.followings
    # counts(@user)
  end
  
  def followers
    @followers = @user.followers
    # counts(@user)
  end
  
  def likes
    @microposts = @user.favorite_microposts.order(id: :desc)
  end
  
  def records
    @records = @user.records.where(finished: true).order(id: :desc)
  end
  
  private
  
  def user_update
    params.require(:user).permit(:name, :email, :gender, :age, :profile_image, :hide_gender, :hide_age, :hide_records)
  end
  
  def user_create
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :age, :profile_image)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def set_count
    counts(@user)
  end
  
end
