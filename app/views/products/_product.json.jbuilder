json.extract! product, :id, :name, :description, :category_id, :supplier_id, :created_at, :updated_at
json.url product_url(product, format: :json)
