# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160727022249) do

  create_table "booking_fares", force: :cascade do |t|
    t.integer  "booking_id"
    t.float    "booking_fee",                  default: 0.0
    t.float    "security",                     default: 0.0
    t.float    "cleaning_charge",              default: 0.0
    t.float    "late_charge",                  default: 0.0
    t.float    "damage_fee",                   default: 0.0
    t.float    "other_charge",                 default: 0.0
    t.float    "total_charge",                 default: 0.0
    t.float    "pending_amount",               default: 0.0
    t.float    "online_payment_done_amount",   default: 0.0
    t.float    "final_settlement_paid_amount", default: 0.0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.float    "refunded_amount",              default: 0.0
  end

  create_table "bookings", force: :cascade do |t|
    t.string   "booking_id"
    t.datetime "booking_time",             null: false
    t.integer  "customer_id",              null: false
    t.integer  "status",       default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "citrus_gateways", force: :cascade do |t|
    t.string   "cirtus_payment_id"
    t.integer  "online_payment_id"
    t.float    "amount",            default: 0.0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "online_payments", force: :cascade do |t|
    t.integer  "booking_fare_id"
    t.string   "payment_modes",   default: "--- []\n"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "paytms", force: :cascade do |t|
    t.string   "paytm_payment_id"
    t.integer  "online_payment_id"
    t.float    "amount",            default: 0.0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
