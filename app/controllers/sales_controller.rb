class SalesController < ApplicationController
  def index
    @products = Product.all
    @products_for_select = @products.map { |p| [p.name, p.id] }
    @products_json = @products.includes(:product_variants).as_json(include: { product_variants: { only: [:id, :size, :color, :material, :price] } })
  end

  def create
    Rails.logger.debug "Params received: #{params.inspect}"

    @sale = Sale.new(date: Date.today, total: params[:sale][:total])

    if @sale.save
      Rails.logger.debug "Sale saved successfully"

      if params[:sale][:items].present?
        items = JSON.parse(params[:sale][:items])
        items.each do |item|
          Rails.logger.debug "Processing item: #{item.inspect}"

          sold_item = @sale.sold_items.create(
            product_variant_id: item["product_variant_id"],
            quantity: item["quantity"],
            price: item["price"]
          )

          Rails.logger.debug "Sold item created: #{sold_item.inspect}"

          update_product_quantity(sold_item)
        end
      else
        Rails.logger.warn "No items were provided in the sale params"
      end

      respond_to do |format|
        format.html { redirect_to sold_items_path, notice: "Sale was successfully created." }
        format.json { render json: { success: true, message: "Sale was successfully created." }, status: :created }
      end
    else
      Rails.logger.debug "Sale failed to save. Errors: #{@sale.errors.full_messages}"

      respond_to do |format|
        format.html { render :index }
        format.json { render json: { success: false, errors: @sale.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  rescue => e
    Rails.logger.error "Error in create action: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")

    respond_to do |format|
      format.html { render :index }
      format.json { render json: { success: false, errors: [e.message] }, status: :internal_server_error }
    end
  end

  private

  def update_product_quantity(sold_item)
    variant = ProductVariant.find(sold_item.product_variant_id)
    variant.decrement!(:stock_quantity, sold_item.quantity)
  end
end
