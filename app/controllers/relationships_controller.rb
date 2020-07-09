class RelationshipsController < ApplicationController
  before_action :require_user_logged_in

  include SessionsHelper

  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'フォローしました'
    redirect_back(fallback_location: '/')
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'フォロー解除しました'
    redirect_back(fallback_location: '/')
  end
end
