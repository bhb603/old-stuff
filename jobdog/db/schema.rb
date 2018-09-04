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

ActiveRecord::Schema.define(:version => 20140308180419) do

  create_table "awards", :force => true do |t|
    t.integer  "job_id",       :null => false
    t.integer  "recipient_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "awards", ["job_id"], :name => "index_awards_on_job_id", :unique => true
  add_index "awards", ["recipient_id"], :name => "index_awards_on_recipient_id"

  create_table "bids", :force => true do |t|
    t.integer  "bidder_id",  :null => false
    t.integer  "job_id",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bids", ["bidder_id", "job_id"], :name => "index_bids_on_bidder_id_and_job_id", :unique => true
  add_index "bids", ["bidder_id"], :name => "index_bids_on_bidder_id"
  add_index "bids", ["job_id"], :name => "index_bids_on_job_id"

  create_table "jobs", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.string   "title",                           :null => false
    t.text     "description"
    t.string   "category"
    t.text     "location"
    t.datetime "complete_by"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "status",      :default => "open", :null => false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "jobs", ["user_id"], :name => "index_jobs_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.text     "content"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",            :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "location"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "google_photo"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id", :unique => true

  create_table "ratings", :force => true do |t|
    t.integer  "rated_id",                      :null => false
    t.integer  "job_id",                        :null => false
    t.integer  "score",                         :null => false
    t.text     "comments"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "completed",  :default => false, :null => false
  end

  add_index "ratings", ["job_id"], :name => "index_ratings_on_job_id"
  add_index "ratings", ["rated_id"], :name => "index_ratings_on_rated_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "session_token"
    t.string   "uid"
    t.string   "provider"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["uid", "provider"], :name => "index_users_on_uid_and_provider", :unique => true

end
