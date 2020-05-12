class SupportsController < ApplicationController
  def create
    record = Record.find(params[:support_id])
    current_user.support(record)
    flash[:success] = "#{record.name}さんを応援しました"
    redirect_back(fallback_location: "/")
  end

  def destroy
    record = Record.find(params[:support_id])
    current_user.unsupport(record)
    flash[:success] = '応援を取り消しました。'
    redirect_back(fallback_location: "/")
  end
  
  def supporters
    @supporters = Support.where(record_id: current_user.records.where(finished: false)) 
  end
end
