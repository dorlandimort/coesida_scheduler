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

ActiveRecord::Schema.define(version: 2019_10_28_200833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctors", force: :cascade do |t|
    t.string "cedula"
    t.boolean "status", default: true, null: false
    t.bigint "user_id"
    t.bigint "work_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_doctors_on_user_id"
    t.index ["work_center_id"], name: "index_doctors_on_work_center_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true, null: false
    t.string "text_color", default: "#FFFFFF", null: false
    t.integer "duration", default: 30, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.json "additional_attributes"
    t.bigint "created_by_id"
    t.bigint "assigned_to_id"
    t.bigint "event_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_to_id"], name: "index_events_on_assigned_to_id"
    t.index ["created_by_id"], name: "index_events_on_created_by_id"
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
  end

  create_table "managers", force: :cascade do |t|
    t.string "description"
    t.boolean "status", default: true, null: false
    t.bigint "user_id"
    t.bigint "work_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_managers_on_user_id"
    t.index ["work_center_id"], name: "index_managers_on_work_center_id"
  end

  create_table "receptionists", force: :cascade do |t|
    t.boolean "status", default: true, null: false
    t.bigint "user_id"
    t.bigint "work_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_receptionists_on_user_id"
    t.index ["work_center_id"], name: "index_receptionists_on_work_center_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "mother_last_name"
    t.boolean "status", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "work_centers", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.string "description"
    t.string "address"
    t.boolean "status", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "doctors", "users"
  add_foreign_key "doctors", "work_centers"
  add_foreign_key "events", "event_types"
  add_foreign_key "managers", "users"
  add_foreign_key "managers", "work_centers"
  add_foreign_key "receptionists", "users"
  add_foreign_key "receptionists", "work_centers"
end
