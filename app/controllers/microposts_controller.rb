class MicropostsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  include SessionsHelper
  
  def index
    if logged_in?
      @micropost = current_user.microposts.build # form_with用
      @microposts = Micropost.order(id: :desc)
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿しました"
      redirect_to microposts_path
    else
      @microposts = Micropost.order(id: :desc)
      flash.now[:danger] = "投稿できませんでした"
      render microposts_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "削除しました"
    redirect_back(flash_location: root_path)
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end
