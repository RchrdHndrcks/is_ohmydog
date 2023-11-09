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

ActiveRecord::Schema[7.1].define(version: 2024_10_25_024342) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "adoption_posts", force: :cascade do |t|
    t.string "dog_name"
    t.integer "dog_age"
    t.string "dog_sex"
    t.string "dog_breed"
    t.string "dog_charac"
    t.string "dog_history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_adoption_posts_on_user_id"
  end

  create_table "appointments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "dog_id"
    t.integer "state", default: 0
    t.integer "timeSlot", default: 0
    t.datetime "appointment_date", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["dog_id"], name: "index_appointments_on_dog_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "breed"
    t.datetime "birthdate"
    t.string "image"
    t.index ["user_id"], name: "index_dogs_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "identifier_number"
    t.string "last_name"
    t.string "address"
    t.string "phone_number"
    t.boolean "es_admin", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adoption_posts", "users"
  add_foreign_key "appointments", "dogs"
  add_foreign_key "appointments", "users"
  add_foreign_key "dogs", "users"
end
