class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.string :label
      t.datetime :start_time
      t.datetime :stop_time
      t.datetime :elapsed_time
      t.boolean :display_support
      t.boolean :null_timer

      t.timestamps
    end
  end
end
