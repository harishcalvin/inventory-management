class CreateSales < ActiveRecord::Migration[7.2]
  def change
    create_table :sales do |t|
      t.date :date
      t.decimal :total

      t.timestamps
    end
  end
end
