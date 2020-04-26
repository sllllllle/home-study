class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.references :user, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
