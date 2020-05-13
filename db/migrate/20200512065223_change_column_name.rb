class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :display_age, :hide_age
    rename_column :users, :display_gender, :hide_gender
    rename_column :users, :display_records, :hide_records
  end
end
