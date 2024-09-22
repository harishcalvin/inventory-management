class HomeController < ApplicationController
  def index
    @product_count = Product.count
  end
end
