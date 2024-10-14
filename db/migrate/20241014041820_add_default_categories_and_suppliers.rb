class AddDefaultCategoriesAndSuppliers < ActiveRecord::Migration[7.2]
  def up
     # categories
     Category.create(name: 'Electronics')
     Category.create(name: 'Clothing')
     Category.create(name: 'Home Appliances')
     Category.create(name: 'Books')

     # suppliers
     Supplier.create(name: 'Supplier A')
     Supplier.create(name: 'Supplier C')
     Supplier.create(name: 'Supplier D')
  end
  def down
    Category.where(name: [ 'Electronics', 'Clothing', 'Home Appliances', 'Books' ]).destroy_all
    Supplier.where(name: [ 'Supplier A', 'Supplier C', 'Supplier D' ]).destroy_all
  end
end
