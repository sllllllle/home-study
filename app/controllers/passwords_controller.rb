class PasswordsController < ApplicationController
  before_action :require_user_logged_in

  def show
    @user = current_user
    redirect_to @user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    current_password = params[:user][:current_password]
    new_password = params[:user][:new_password]
    password_confirmation = params[:user][:password_confirmation]

    if current_password.present?
      if @user.authenticate(current_password)
        if new_password == password_confirmation
          if new_password != current_password
            flash[:success] = '変更は行われませんでした'
            redirect_to @user
          else
            if @user.update(password: new_password)
              flash[:success] = 'パスワードを変更しました'
              redirect_to @user
            else
              flash[:danger] = '変更に失敗しました'
              render :edit
            end
          end
        else
          flash[:danger] = '新しいパスワードが一致しません'
          render :edit
        end
      else
        flash[:danger] = '現在のパスワードが正しくありません'
        render :edit
      end
    else
      flash[:danger] = '現在のパスワードを入力してください'
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:current_password, :new_password, :password_confirmation)
  end
end
