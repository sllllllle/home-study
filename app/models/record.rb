class Record < ApplicationRecord
  validates :label, length: { maximum: 30 }
  validates :start_time, presence: true

  belongs_to :user

  has_many :supports, dependent: :destroy
  has_many :supporter, through: :supports, source: :user

  def feed_records
    Record.where(finished: false)
  end

  def add_elapsed_time
    stop_time = Time.zone.now
    self.elapsed_time += stop_time.to_i - start_time.to_i
  end
  
  def stop
    self.add_elapsed_time
    self.start_time = Time.zone.now
    self.stopped = true
    self.save
  end
  
  def restart
    self.start_time = Time.zone.now
    self.stopped = false
    self.save
  end
  
end
