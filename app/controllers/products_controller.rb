class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

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
    @product.product_variants.build.build_variant.variant_options.build if @product.product_variants.empty?
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
      if @product.update(product_params)
        if params[:variants].present?
          variants = JSON.parse(params[:variants])
          @product.product_variants.destroy_all
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
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def create_default_variant
      @product.product_variants.create(price: params[:price], stock_quantity: params[:stock_quantity])
    end
    def set_product
      @product = Product.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :category_id, :supplier_id, :price, :stock_quantity)
    end
end
