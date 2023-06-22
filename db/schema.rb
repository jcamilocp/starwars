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

ActiveRecord::Schema[7.0].define(version: 2023_06_22_152004) do
  create_table "Film", force: :cascade do |t|
    t.text "title"
    t.integer "episode_id"
    t.text "opening_crawl"
    t.text "director"
    t.text "producer"
    t.datetime "release_date", precision: nil
  end

# Could not dump table "Film_People" because of following StandardError
#   Unknown type '' for column 'film_id'

# Could not dump table "Film_Planet" because of following StandardError
#   Unknown type '' for column 'film_id'

# Could not dump table "People" because of following StandardError
#   Unknown type '' for column 'planet_id'

  create_table "Planet", force: :cascade do |t|
    t.text "name"
    t.text "diameter"
    t.text "rotation_period"
    t.text "orbital_period"
    t.text "gravity"
    t.text "population"
    t.text "climate"
    t.text "terrain"
    t.text "surface_water"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "Film_People", "Film", column: "film_id"
  add_foreign_key "Film_People", "People", column: "people_id"
  add_foreign_key "Film_Planet", "Film", column: "film_id"
  add_foreign_key "Film_Planet", "Planets", column: "planet_id"
  add_foreign_key "People", "Planets", column: "planet_id"
end
