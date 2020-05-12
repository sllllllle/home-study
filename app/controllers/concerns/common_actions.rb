module CommonActions
  extend ActiveSupport::Concern
  
  def finish_record
    @record.finished = true
    if @record.stopped
      @record.save
    else
      @record.add_elapsed_time
      @record.save
    end
  end
end