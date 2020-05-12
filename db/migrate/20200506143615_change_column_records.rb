class ChangeColumnRecords < ActiveRecord::Migration[5.2]
  def change
    change_column :records, :stop_time, :time
    change_column :records, :start_time, :time
  end
end
