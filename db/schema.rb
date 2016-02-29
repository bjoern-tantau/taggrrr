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

ActiveRecord::Schema.define(version: 20160226145018) do

  create_table "directories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "path_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "directories", ["parent_id"], name: "index_directories_on_parent_id"
  add_index "directories", ["path_id"], name: "index_directories_on_path_id"

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "file_hash"
    t.string   "image_hash"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "directory_id"
  end

  add_index "images", ["directory_id"], name: "index_images_on_directory_id"

  create_table "paths", force: :cascade do |t|
    t.string   "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "label"
    t.text     "value"
    t.integer  "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["image_id"], name: "index_tags_on_image_id"

end
