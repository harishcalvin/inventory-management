class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update soft_delete confirm_soft_delete ]

  # GET /products or /products.json
  def index
    @products = Product.includes(:category, :supplier, :product_variants).all
  end
  # GET /products/1 or /products/1.json
  def show
    @product = Product.includes(:category, :supplier, :product_variants).find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
    if params[:variant] == "true"
      @product.product_variants.build
    end
  end
  # GET /products/1/edit
  def edit
    @product.product_variants.build if @product.product_variants.empty?
  end

  def variants
    product = Product.find(params[:id])
    variants = product.product_variants.map { |v| { id: v.id, name: v.display_name, price: v.price } }
    render json: { has_variants: variants.any?, variants: variants }
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params.except(:price, :stock_quantity))
    respond_to do |format|
      if @product.save
        if product_params[:price].present? && product_params[:stock_quantity].present?
          # Create a default variant for products without explicit variants
          @product.product_variants.create(
            size: "Default",
            price: product_params[:price],
            stock_quantity: product_params[:stock_quantity]
          )
        elsif params[:variants].present?
          # Create variants for products with explicit variants
          variants = JSON.parse(params[:variants])
          variants.each do |variant|
            @product.product_variants.create(
              size: variant["size"],
              color: variant["color"],
              material: variant["material"],
              price: variant["price"],
              stock_quantity: variant["stock_quantity"]
            )
          end
        end
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params.except(:price, :stock_quantity))
        if params[:variants].present?
          update_explicit_variants(JSON.parse(params[:variants]))
        else
          update_single_variant
        end
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def soft_delete
    if @product.update(deleted_at: Time.current)
      redirect_to products_path, notice: "Product '#{@product.name}' has been archived."
    else
      redirect_to @product, alert: "Failed to archive the product."
    end
  end

  def archive
    @archived_products = Product.unscoped.where.not(deleted_at: nil)
  end

  # def restore
  #   if @product.update(deleted_at: nil)
  #     redirect_to archive_products_path, notice: "Product '#{@product.name}' has been restored."
  #   else
  #     redirect_to archive_products_path, alert: "Failed to restore the product."
  #   end
  # end
  def restore
    @product = Product.unscoped.find_by(id: params[:id])

    if @product.nil?
      redirect_to archive_products_path, alert: "Product not found."
    elsif @product.update(deleted_at: nil)
      redirect_to archive_products_path, notice: "Product '#{@product.name}' has been restored."
    else
      redirect_to archive_products_path, alert: "Failed to restore the product."
    end
  end

  def confirm_soft_delete
    if @product.update(deleted_at: Time.current)
      redirect_to products_path, notice: "product '#{@product.name}' was successfully archived."
    else
        redirect_to products_path, alert: "There was an error archiving the product."
    end
  end

  private
  def update_explicit_variants(variants)
    variants.each do |variant|
      existing_variant = @product.product_variants.find_or_initialize_by(
        size: variant["size"],
        color: variant["color"],
        material: variant["material"]
      )
      existing_variant.price = variant["price"] if variant["price"].present?
      existing_variant.stock_quantity = variant["stock_quantity"] if variant["stock_quantity"].present?
      existing_variant.save
    end
  end

  def update_single_variant
    variant = @product.product_variants.first_or_create(size: "Default")
    if params[:product][:price].present? || params[:product][:stock_quantity].present?
      variant.update(
        price: params[:product][:price] || variant.price,
        stock_quantity: params[:product][:stock_quantity] || variant.stock_quantity
      )
    end
  end
    def set_product
      @product = Product.unscoped.find(params[:id])
      redirect_to products_path, alert: "Product not found." if @product.nil?
    end
    # Use callbacks to share common setup or constraints between actions.
    def create_default_variant
      @product.product_variants.create(price: params[:price], stock_quantity: params[:stock_quantity])
    end
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :category_id, :supplier_id, :price, :stock_quantity)
    end
end
