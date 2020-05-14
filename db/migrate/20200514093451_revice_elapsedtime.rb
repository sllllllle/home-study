class ReviceElapsedtime < ActiveRecord::Migration[5.2]
  def change
    def change
    change_column :records, :elapsed_time, 'bigint USING CAST(elapsed_time AS bigint)'
    end
  end
end
