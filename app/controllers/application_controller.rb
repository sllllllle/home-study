class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  def counts(user)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
end
