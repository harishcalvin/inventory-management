class SoldItemsController < ApplicationController
  def index
    @sales = Sale.includes(sold_items: { product_variant: :product }).order(date: :desc)
     @sales = @sales.where(date: params[:start_date]..params[:end_date]) if params[:start_date].present? && params[:end_date].present?
  end
end
