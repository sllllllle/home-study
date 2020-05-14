class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :stop, :restart, :result]
  before_action :show_validate, only: [:show]
  before_action :create_validate, only: [:create]
  
  def index
    @records = Record.where(finished: false)
  end
  
  def show
  end
  
  def new
    @record = Record.new
  end
  
  
  def create
    @record = current_user.records.build(record_create)
    @record.start_time = Time.now
    @record.elapsed_time = 0
    @record.stopped = false
    @record.finished = false
    if @record.save
      flash[:success] = "開始しました"
      redirect_to records_path
    else
      flash.now[:danger] = "開始できませんでした"
      render :new
    end
  end
  
  def stop
    @record.add_elapsed_time
    @record.start_time = Time.now
    @record.stopped = true
    @record.save
    redirect_back(fallback_location: "/")
  end
  
  def restart
    @record.start_time = Time.now
    @record.stopped = false
    @record.save
    redirect_back(fallback_location: "/")
  end
  
  def finish
    finish_record
    render :result
  end
  
  def result
  end
  
  private
  
  def set_record
    @record = Record.find(params[:id])
  end
  
  def record_create
    params.require(:record).permit(:label, :hide_support, :null_timer)
  end
  
  def show_validate
    if @record.finished
      flash[:danger] = "既に勉強を終了しています。"
      redirect_to action: :new
    else
      return
    end
  end
  
  def create_validate
    if current_user.records.where(finished: false).size >= 1
      flash[:danger] = "既に勉強を開始しています"
      redirect_to action: :new
    else
      return
    end
  end
end