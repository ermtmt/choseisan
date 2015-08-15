ActiveRecord::Schema.define(version: 20150809073316) do

  create_table "users", force: :cascade do |t|
    t.string   "login_id",           limit: 255, default: "", null: false
    t.string   "encrypted_password", limit: 255, default: "", null: false
    t.string   "name",               limit: 255, default: "", null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "users", ["login_id"], name: "index_users_on_login_id", unique: true, using: :btree

end
