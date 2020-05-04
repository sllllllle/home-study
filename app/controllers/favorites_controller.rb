class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    micropost = Micropost.find(params[:favorite_id])
    current_user.favorite(micropost)
    flash[:success] = "お気に入りに追加しました。"
    redirect_back(fallback_location: "/")
  end

  def destroy
    micropost = Micropost.find(params[:favorite_id])
    current_user.unfavorite(micropost)
    flash[:success] = 'お気に入りを取り消しました。。'
    redirect_back(fallback_location: "/")
  end
end
