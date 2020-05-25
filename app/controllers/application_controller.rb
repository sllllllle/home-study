class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_user_logged_in
    redirect_to :root unless logged_in?
  end

  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.favorites.count
    @count_records = user.feed_records.count
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
