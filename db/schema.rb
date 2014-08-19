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

ActiveRecord::Schema.define(version: 20140819124405) do

  create_table "contents", force: true do |t|
    t.string   "api_url"
    t.integer  "index",      default: 0, null: false
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "lists", force: true do |t|
    t.string  "name"
    t.string  "sector_id"
    t.integer "index",     default: 0, null: false
  end

  add_index "lists", ["sector_id"], name: "index_lists_on_sector_id", using: :btree

  create_table "users", force: true do |t|
    t.string  "name"
    t.string  "email"
    t.string  "uid"
    t.string  "organisation_slug"
    t.string  "permissions"
    t.boolean "remotely_signed_out", default: false
  end

end