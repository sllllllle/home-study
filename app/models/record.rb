class Record < ApplicationRecord
  belongs_to :user
  
  def feed_records
    Record.where(finished: false)
  end
  
  def add_elapsed_time
    stop_time = Time.zone.now
    self.elapsed_time += stop_time.to_i - self.start_time.to_i
  end
end