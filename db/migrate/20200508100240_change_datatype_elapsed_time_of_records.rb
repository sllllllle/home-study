class ChangeDatatypeElapsedTimeOfRecords < ActiveRecord::Migration[5.2]
  def change
    change_column :records, :elapsed_time, :bigint
  end
end
