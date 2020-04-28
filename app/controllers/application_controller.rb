class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  def counts(user)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.favorites.count
  end
end
