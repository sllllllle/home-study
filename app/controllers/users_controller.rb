class UsersController < ApplicationController
  before_action :set_user, only: %i[
    show
    update
    edit_password
    update_password
    followings
    followers
    likes
    records
  ]
  before_action :set_count, only: %i[show likes records]
  before_action :require_user_logged_in, only: %i[show edit]
  before_action :correct_user, only: [:edit]

  def show
    @microposts = @user.microposts.order(id: :desc)
  end

  def new
    @user = User.new
  end

  def edit; end

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

  def followings
    @followings = @user.followings
  end

  def followers
    @followers = @user.followers
  end

  def likes
    @microposts = @user.favorite_microposts.order(id: :desc)
  end

  def records
    @records = @user.records.where(finished: true).order(id: :desc)
  end

  private

  def user_update
    params.require(:user).permit(:name, :email, :gender, :age, :img, :remove_img, :hide_gender, :hide_age, :hide_records)
  end

  def user_create
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :age, :img)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_count
    counts(@user)
  end

  def correct_user
    if User.find(params[:id]) != current_user
      @user = User.find(params[:id])
      redirect_to @user
    else
      @user = User.find(params[:id])
    end
  end
end
