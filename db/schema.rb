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

ActiveRecord::Schema.define(version: 20150829231844) do

  create_table "event_entries", force: :cascade do |t|
    t.integer  "event_id",   limit: 4,   null: false
    t.integer  "user_id",    limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "comment",    limit: 255
  end

  add_index "event_entries", ["event_id", "user_id"], name: "index_event_entries_on_event_id_and_user_id", unique: true, using: :btree
  add_index "event_entries", ["event_id"], name: "index_event_entries_on_event_id", using: :btree
  add_index "event_entries", ["user_id", "event_id"], name: "index_event_entries_on_user_id_and_event_id", unique: true, using: :btree
  add_index "event_entries", ["user_id"], name: "index_event_entries_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "memo",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "hash_id",    limit: 255,   null: false
  end

  add_index "events", ["hash_id"], name: "index_events_on_hash_id", unique: true, using: :btree

  create_table "option_entries", force: :cascade do |t|
    t.integer  "feeling",        limit: 4, default: 0, null: false
    t.integer  "option_id",      limit: 4,             null: false
    t.integer  "event_entry_id", limit: 4,             null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "option_entries", ["event_entry_id", "option_id"], name: "index_option_entries_on_event_entry_id_and_option_id", unique: true, using: :btree
  add_index "option_entries", ["event_entry_id"], name: "index_option_entries_on_event_entry_id", using: :btree
  add_index "option_entries", ["option_id", "event_entry_id"], name: "index_option_entries_on_option_id_and_event_entry_id", unique: true, using: :btree
  add_index "option_entries", ["option_id"], name: "index_option_entries_on_option_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "text",       limit: 255, null: false
    t.integer  "event_id",   limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "options", ["event_id"], name: "index_options_on_event_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login_id",           limit: 255, default: "", null: false
    t.string   "encrypted_password", limit: 255, default: "", null: false
    t.string   "name",               limit: 255, default: "", null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "users", ["login_id"], name: "index_users_on_login_id", unique: true, using: :btree

  add_foreign_key "event_entries", "events"
  add_foreign_key "event_entries", "users"
  add_foreign_key "option_entries", "event_entries"
  add_foreign_key "option_entries", "options"
  add_foreign_key "options", "events"
end
