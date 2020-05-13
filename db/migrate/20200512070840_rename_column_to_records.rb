class RenameColumnToRecords < ActiveRecord::Migration[5.2]
  def change
    rename_column :records, :display_support, :hide_support
  end
end
