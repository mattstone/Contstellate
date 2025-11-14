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

ActiveRecord::Schema[8.0].define(version: 2025_11_14_003136) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "galaxies", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", null: false
    t.string "icon"
    t.text "description"
    t.integer "question_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_galaxies_on_name", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "galaxy_id", null: false
    t.integer "used_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["galaxy_id"], name: "index_questions_on_galaxy_id"
    t.index ["used_count"], name: "index_questions_on_used_count"
  end

  create_table "reflections", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.bigint "question_id", null: false
    t.text "note"
    t.string "voice_recording_url"
    t.string "reflection_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_reflections_on_question_id"
    t.index ["session_id"], name: "index_reflections_on_session_id"
  end

  create_table "session_galaxies", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.bigint "galaxy_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["galaxy_id"], name: "index_session_galaxies_on_galaxy_id"
    t.index ["session_id"], name: "index_session_galaxies_on_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "mode", null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer "galaxies_visited", default: 0
    t.integer "player_count", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode"], name: "index_sessions_on_mode"
    t.index ["started_at"], name: "index_sessions_on_started_at"
  end

  add_foreign_key "questions", "galaxies"
  add_foreign_key "reflections", "questions"
  add_foreign_key "reflections", "sessions"
  add_foreign_key "session_galaxies", "galaxies"
  add_foreign_key "session_galaxies", "sessions"
end
