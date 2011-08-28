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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110828210640) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
  end

  create_table "events", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.text     "review"
    t.datetime "published_at"
    t.string   "address"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "venue"
    t.string   "signup_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "slug"
    t.boolean  "all_day_event"
    t.string   "eventbrite_id"
    t.string   "url"
  end

  create_table "options", :force => true do |t|
    t.string   "domain"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.text     "slug"
    t.datetime "published_at"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sidebar_title"
    t.boolean  "show_in_sidebar"
    t.integer  "user_id"
  end

  create_table "posts", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "user_id",      :default => 1
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "url"
    t.text     "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "image"
  end

end
