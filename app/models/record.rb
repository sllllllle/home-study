class Record < ApplicationRecord
  validates :label, length: { maximum: 30 }

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
end
