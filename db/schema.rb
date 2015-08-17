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

ActiveRecord::Schema.define(version: 20150817081922) do

  create_table "event_options", force: :cascade do |t|
    t.string   "option",     limit: 255, null: false
    t.integer  "event_id",   limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "event_options", ["event_id"], name: "index_event_options_on_event_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "memo",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "hash_id",    limit: 255,   null: false
  end

  add_index "events", ["hash_id"], name: "index_events_on_hash_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login_id",           limit: 255, default: "", null: false
    t.string   "encrypted_password", limit: 255, default: "", null: false
    t.string   "name",               limit: 255, default: "", null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "users", ["login_id"], name: "index_users_on_login_id", unique: true, using: :btree

  add_foreign_key "event_options", "events"
end
