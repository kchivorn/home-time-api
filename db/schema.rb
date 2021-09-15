# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_15_003047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.text "phone", default: [], null: false, array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.string "reservation_code", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "nights", null: false
    t.integer "guests", null: false
    t.integer "adults", null: false
    t.string "guest_localized_desc"
    t.integer "children", null: false
    t.integer "infants", null: false
    t.integer "status", null: false
    t.bigint "guest_id", null: false
    t.string "currency", null: false
    t.decimal "payout_price", precision: 16, scale: 2, null: false
    t.decimal "security_price", precision: 16, scale: 2, null: false
    t.decimal "total_price", precision: 16, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["reservation_code"], name: "index_reservations_on_reservation_code", unique: true
  end

end
