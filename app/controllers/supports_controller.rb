class SupportsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    record = Record.find(params[:support_id])
    current_user.support(record)
    redirect_back(fallback_location: "/")
  end

  def destroy
    record = Record.find(params[:support_id])
    current_user.unsupport(record)
    redirect_back(fallback_location: "/")
  end
  
  def supporters
    @supporters = Support.where(record_id: current_user.records.where(finished: false)) 
  end
end
