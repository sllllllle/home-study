class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def unfinished_records
    records.where(finished: false)
  end
end
