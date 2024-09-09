class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.references :categories, null: false, foreign_key: true
      t.references :suppliers, null: false, foreign_key: true

      t.timestamps
    end
  end
end
