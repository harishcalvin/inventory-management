class SoldItemsController < ApplicationController
  def index
    @sales = Sale.includes(sold_items: { product_variant: :product }).order(date: :desc)
  end
end
