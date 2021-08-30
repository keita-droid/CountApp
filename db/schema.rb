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

ActiveRecord::Schema.define(version: 2021_08_24_022924) do

  create_table "business_days", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date", null: false
    t.boolean "weekend_operation", default: false, null: false
    t.integer "max_of_13"
    t.integer "max_of_14"
    t.integer "max_of_15"
    t.integer "max_of_16"
    t.integer "max_of_17"
    t.integer "max_of_18"
    t.integer "max_of_19"
    t.integer "max_of_20"
    t.integer "max_of_21"
    t.bigint "month_id", null: false
    t.bigint "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["month_id"], name: "index_business_days_on_month_id"
    t.index ["school_id"], name: "index_business_days_on_school_id"
  end

  create_table "business_hours", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "current_stay", default: 0
    t.integer "maximum_stay", default: 0
    t.integer "coming", default: 0
    t.integer "leaving", default: 0
    t.integer "leave_count", default: 0
    t.integer "hour", null: false
    t.bigint "business_day_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_day_id"], name: "index_business_hours_on_business_day_id"
  end

  create_table "months", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "month", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "seats", null: false
    t.index ["email"], name: "index_schools_on_email", unique: true
    t.index ["reset_password_token"], name: "index_schools_on_reset_password_token", unique: true
  end

  add_foreign_key "business_days", "months"
  add_foreign_key "business_days", "schools"
  add_foreign_key "business_hours", "business_days"
end
