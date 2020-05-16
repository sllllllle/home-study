class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :gender
      t.integer :age
      t.string :password_digest
      t.string :img
      t.boolean :hide_gender
      t.boolean :hide_age
      t.boolean :hide_records

      t.timestamps
    end
  end
end
