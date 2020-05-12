module RecordsHelper
  def support_counts(record)
    Support.where(record_id: record.id).count
  end  
end