class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def index
    if logged_in?
      @micropost = current_user.microposts.build # form_with用
      @microposts = Micropost.order(id: :desc)
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '投稿しました'
      redirect_to microposts_path
    else
      @microposts = Micropost.order(id: :desc)
      flash[:danger] = '投稿できませんでした'
      redirect_to microposts_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '削除しました'
    redirect_back(fallback_location: root_path)
  end

  def following_posts
    @micropost = current_user.microposts.build
    @microposts = current_user.feed_microposts.order(id: :desc)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url unless @micropost
  end
end
