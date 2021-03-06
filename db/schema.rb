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

ActiveRecord::Schema.define(version: 20150824055140) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,     null: false
    t.integer  "tip_id",     limit: 4,     null: false
    t.text     "content",    limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["tip_id", "user_id"], name: "index_comments_on_tip_id_and_user_id", using: :btree
  add_index "comments", ["user_id"], name: "fk_rails_03de2dc08c", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "tip_id",     limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "stocks", ["tip_id"], name: "index_stocks_on_tip_id", using: :btree
  add_index "stocks", ["user_id", "tip_id"], name: "index_stocks_on_user_id_and_tip_id", unique: true, using: :btree
  add_index "stocks", ["user_id"], name: "index_stocks_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tips", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,     null: false
    t.string   "title",      limit: 255,   null: false
    t.text     "content",    limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "tips", ["created_at"], name: "index_tips_on_created_at", using: :btree
  add_index "tips", ["user_id", "created_at"], name: "index_tips_on_user_id_and_created_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255,                 null: false
    t.string   "email_for_index", limit: 255,                 null: false
    t.string   "name",            limit: 255,                 null: false
    t.string   "hashed_password", limit: 255
    t.date     "start_date",                                  null: false
    t.date     "end_date"
    t.boolean  "suspended",       limit: 1,   default: false, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "provider",        limit: 255
    t.string   "uid",             limit: 255
    t.string   "screen_name",     limit: 255
  end

  add_index "users", ["email_for_index"], name: "index_users_on_email_for_index", unique: true, using: :btree

  add_foreign_key "comments", "tips"
  add_foreign_key "comments", "users"
  add_foreign_key "stocks", "tips"
  add_foreign_key "stocks", "users"
  add_foreign_key "tips", "users"
end
