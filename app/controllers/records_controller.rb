class RecordsController < ApplicationController
  before_action :require_user_logged_in, only: [:new]
  before_action :set_record, only: %i[show stop restart result]
  before_action :show_validate, only: [:show]
  before_action :create_validate, only: [:new]

  def index
    @records = Record.where(finished: false)
  end

  def show; end

  def new
    @record = Record.new
  end

  def create
    @record = current_user.records.build(record_create)
    @record.start_time = Time.zone.now
    @record.elapsed_time = 0
    @record.stopped = false
    @record.finished = false
    if @record.save
      flash[:success] = '勉強を開始しました。'
      redirect_to records_path
    else
      flash.now[:danger] = '勉強を開始できませんでした。'
      render :new
    end
  end

  def stop
    @record.stop
    redirect_back(fallback_location: '/')
  end

  def restart
    @record.restart
    redirect_back(fallback_location: '/')
  end

  def finish
    finish_record
    render :result
  end

  def result; end

  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_create
    params.require(:record).permit(:label, :hide_support, :null_timer)
  end

  def show_validate
    if @record.finished
      flash[:danger] = '既に勉強を終了しています。'
      redirect_to action: :new
    end
  end

  def create_validate
    if current_user.records.where(finished: false).size >= 1
      flash[:danger] = '既に勉強を開始しています。'
      redirect_to action: :index
    end
  end
end
