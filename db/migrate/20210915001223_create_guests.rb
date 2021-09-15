class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.text :phone, array: true, default: [], null: false

      t.timestamps
    end
    add_index :guests, :email, unique: true
  end
end
