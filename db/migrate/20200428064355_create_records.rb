class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.string :label
      t.time :start_time
      t.time :stop_time
      t.bigint :elapsed_time
      t.boolean :hide_support
      t.boolean :null_timer
      t.boolean :stopped
      t.boolean :finished
      
      t.timestamps
    end
  end
end
