class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :finish, :result]
  before_action :show_validate, only: [:show]
  before_action :create_validate, only: [:create]
  
  def show
  end
  
  def new
    @record = Record.new
  end
  
  def edit
  end
  
  def create
    @record = current_user.records.build(record_create)
    @record.start_time = Time.zone.now
    @record.elapsed_time = 0
    @record.finished = false
    if @record.save
      flash[:success] = "開始しました"
      redirect_to @record
    else
      flash.now[:danger] = "開始できませんでした"
      render :new
    end
  end
  
  def update
    @record.add_elapsed_time
    @record.save
    @record.start_time = Time.now
    redirect_to @record
  end
  
  def finish
    @record.add_elapsed_time
    @record.finished = true
    @record.save
    render :result
  end
  
  def result
  end
  
  private
  
  def set_record
    @record = Record.find(params[:id])
  end
  
  def record_create
    params.require(:record).permit(:label, :display_support, :null_timer)
  end
  
  def show_validate
    if @record.finished == true
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