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

ActiveRecord::Schema[8.0].define(version: 2025_02_12_171821) do
  create_table "history_entries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.integer "entry_type"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_history_entries_on_project_id"
    t.index ["user_id"], name: "index_history_entries_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 0
    t.integer "client_id", null: false
    t.integer "agent_id"
    t.integer "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_projects_on_agent_id"
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["vendor_id"], name: "index_projects_on_vendor_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "history_entries", "projects"
  add_foreign_key "history_entries", "users"
  add_foreign_key "projects", "users", column: "agent_id"
  add_foreign_key "projects", "users", column: "client_id"
  add_foreign_key "projects", "users", column: "vendor_id"
end
