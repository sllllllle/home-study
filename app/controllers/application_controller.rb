class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to :root
    end
  end
  
  def counts(user, record)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.favorites.count
  end
  
  
  
  def finish_record
    @record = current_user.unfinished_records.last
    @record.finished = true
    if @record.stopped
      @record.save
    else
      @record.add_elapsed_time
      @record.save
    end
  end
  
end