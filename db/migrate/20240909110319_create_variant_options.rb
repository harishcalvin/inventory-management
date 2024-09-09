class CreateVariantOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :variant_options do |t|
      t.references :variants, null: false, foreign_key: true
      t.string :options

      t.timestamps
    end
  end
end
