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

ActiveRecord::Schema[7.2].define(version: 2024_09_09_110439) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.decimal "gst"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_variants", force: :cascade do |t|
    t.integer "products_id", null: false
    t.integer "variants_id", null: false
    t.decimal "price"
    t.integer "stock_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["products_id"], name: "index_product_variants_on_products_id"
    t.index ["variants_id"], name: "index_product_variants_on_variants_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "categories_id", null: false
    t.integer "suppliers_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories_id"], name: "index_products_on_categories_id"
    t.index ["suppliers_id"], name: "index_products_on_suppliers_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variant_options", force: :cascade do |t|
    t.integer "variants_id", null: false
    t.string "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["variants_id"], name: "index_variant_options_on_variants_id"
  end

  create_table "variants", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "product_variants", "products", column: "products_id"
  add_foreign_key "product_variants", "variants", column: "variants_id"
  add_foreign_key "products", "categories", column: "categories_id"
  add_foreign_key "products", "suppliers", column: "suppliers_id"
  add_foreign_key "variant_options", "variants", column: "variants_id"
end
