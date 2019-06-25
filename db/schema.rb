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

ActiveRecord::Schema.define(version: 2019_06_20_004806) do

  create_table "posts", force: :cascade do |t|
    t.integer "room_number"
    t.integer "matches"
    t.integer "matches_a"
    t.integer "matches_b"
    t.integer "matches_c"
    t.integer "matches_d"
    t.integer "priority3"
    t.integer "priority2"
    t.integer "priority1"
    t.integer "uma"
    t.float "rate"
    t.integer "buck"
    t.text "hako"
    t.text "tobi"
    t.text "yakitori"
    t.text "yakuman"
    t.text "rule"
    t.boolean "finish"
    t.text "score_a"
    t.text "score_b"
    t.text "score_c"
    t.text "score_d"
    t.text "name_a"
    t.text "name_b"
    t.text "name_c"
    t.text "name_d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "pass"
    t.integer "rate"
    t.integer "winning"
    t.integer "matches"
    t.integer "total_score"
    t.integer "money"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.string "image_name"
  end

end
