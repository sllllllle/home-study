class SupportsController < ApplicationController
  before_action :require_user_logged_in

  # def create
  #   record = Record.find(params[:support_id])
  #   current_user.support(record)
  #   redirect_back(fallback_location: '/')
  # end

  def create
    @record = Record.find(params[:support_id])
    @yell = current_user.support(@record)
  end

  # def destroy
  #   record = Record.find(params[:support_id])
  #   current_user.unsupport(record)
  #   redirect_back(fallback_location: '/')
  # end

  def destroy
    @record = Record.find(params[:support_id])
    @yell = current_user.unsupport(@record)
  end

  def supporters
    @record = current_user.unfinished_records.last if current_user
    @supporters = @record.supporter
  end
end
