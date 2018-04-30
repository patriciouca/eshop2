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

ActiveRecord::Schema.define(version: 20190702175418) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.integer  "cart_id",    limit: 4
    t.float    "price",      limit: 24
    t.integer  "amount",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directors", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "directors_movies", force: :cascade do |t|
    t.integer  "director_id", limit: 4, null: false
    t.integer  "movie_id",    limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "directors_movies", ["director_id"], name: "fk_directors_movies_directors", using: :btree
  add_index "directors_movies", ["movie_id"], name: "fk_directors_movies_movies", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "title",                    limit: 255,   null: false
    t.integer  "producer_id",              limit: 4,     null: false
    t.datetime "produced_at"
    t.string   "serial_number",            limit: 5
    t.text     "blurb",                    limit: 65535
    t.integer  "length",                   limit: 4
    t.float    "price",                    limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_image_file_name",    limit: 255
    t.string   "cover_image_content_type", limit: 255
    t.integer  "cover_image_file_size",    limit: 4
    t.datetime "cover_image_updated_at"
  end

  add_index "movies", ["producer_id"], name: "fk_movies_producers", using: :btree

  create_table "producers", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "directors_movies", "directors", name: "fk_directors_movies_directors", on_delete: :cascade
  add_foreign_key "directors_movies", "movies", name: "fk_directors_movies_movies", on_delete: :cascade
  add_foreign_key "movies", "producers", name: "fk_movies_producers", on_delete: :cascade
end
