class CreateVariants < ActiveRecord::Migration[7.2]
  def change
    create_table :variants do |t|
      t.string :type

      t.timestamps
    end
  end
end
