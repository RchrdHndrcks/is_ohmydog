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

ActiveRecord::Schema[7.1].define(version: 2024_10_25_024346) do
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
    t.boolean "is_adopted"
    t.index ["user_id"], name: "index_adoption_posts_on_user_id"
  end

  create_table "appointments", id: :serial, force: :cascade do |t|
    t.integer "state", default: 0
    t.integer "timeSlot", default: 0
    t.datetime "appointment_date", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "appointments_dogs", force: :cascade do |t|
    t.bigint "dog_id", null: false
    t.bigint "appointment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_appointments_dogs_on_appointment_id"
    t.index ["dog_id", "appointment_id"], name: "index_appointments_dogs_on_dog_id_and_appointment_id", unique: true
    t.index ["dog_id"], name: "index_appointments_dogs_on_dog_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "breed"
    t.datetime "birthdate"
    t.string "image"
    t.string "colour"
    t.string "observations"
    t.index ["user_id"], name: "index_dogs_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_news_on_user_id"
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'news' for column 'news'

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "users"
  add_foreign_key "appointments_dogs", "appointments"
  add_foreign_key "appointments_dogs", "dogs"
  add_foreign_key "dogs", "users"
  add_foreign_key "news", "users"
end
