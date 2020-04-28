class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers, :following_posts]
  
  
  def show
    @microposts = @user.microposts.order(id: :desc)
    # counts(@user)
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
  
  # def following_posts
  #   @microposts = @user.feed_micropost.sorder(id: :desc)
  # end
  
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
