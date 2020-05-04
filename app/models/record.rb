class Record < ApplicationRecord
  belongs_to :user
  
  def feed_records
    Record.where(finished: false)
  end
end
