class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :gender
      t.integer :age
      t.string :password_digest
      t.string :profile_image
      t.boolean :display_gender
      t.boolean :display_age
      t.boolean :display_records

      t.timestamps
    end
  end
end
