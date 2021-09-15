class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :reservation_code, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :nights, null: false
      t.integer :guests, null: false
      t.integer :adults, null: false
      t.string :guest_localized_desc
      t.integer :children, null: false
      t.integer :infants, null: false
      t.integer :status, null: false
      t.references :guest, null: false
      t.string :currency, null: false
      t.decimal :payout_price, precision: 16, scale: 2, null: false
      t.decimal :security_price, precision: 16, scale: 2, null: false
      t.decimal :total_price, precision: 16, scale: 2, null: false

      t.timestamps
    end
    add_index :reservations, :reservation_code, unique: true
  end
end
