class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def unfinished_records
    self.records.where(finished: false)
  end
end
