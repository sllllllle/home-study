class CreateSupports < ActiveRecord::Migration[5.2]
  def change
    create_table :supports do |t|
      t.references :user, foreign_key: true
      t.references :record, foreign_key: true

      t.timestamps

      t.index %i[user_id record_id], unique: true
    end
  end
end
