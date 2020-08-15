class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    @micropost = Micropost.find(params[:favorite_id])
    @like = current_user.favorite(@micropost)
  end

  def destroy
    @micropost = Micropost.find(params[:favorite_id])
    @like = current_user.unfavorite(@micropost)
  end
end
