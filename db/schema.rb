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

ActiveRecord::Schema[7.0].define(version: 2022_11_14_104450) do
  create_table "transaction_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "source_id", null: false
    t.integer "target_id", null: false
    t.integer "transaction_types_id", null: false
    t.index ["source_id"], name: "index_transactions_on_source_id"
    t.index ["target_id"], name: "index_transactions_on_target_id"
    t.index ["transaction_types_id"], name: "index_transactions_on_transaction_types_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "transactions", "wallets", column: "source_id"
  add_foreign_key "transactions", "wallets", column: "target_id"
end
