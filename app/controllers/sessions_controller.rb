class SessionsController < ApplicationController
  include ApplicationHelper

  before_action :finish_record, only: [:destroy], if: :studying?

  def new; end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインしました'
      redirect_to @user
    else
      flash[:danger] = 'ログインに失敗しました'
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user&.authenticate(password)
      session[:user_id] = @user.id
      true
    else
      false
    end
  end
end
