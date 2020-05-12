class AddStoppedToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :stopped, :boolean
  end
end
