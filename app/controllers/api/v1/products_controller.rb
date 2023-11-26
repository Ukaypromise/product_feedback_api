class Api::V1::ProductsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @products = @company.products.order(created_at: :desc)
    render json: {
             data: @products,
           }
  end

  def get_all_products
    @products = Product.includes(:company).order(created_at: :desc)
    render json: {
             data: @products.map { |product|
               { product: product, company: product.company }
             },
           }
  end

  def create
    @product = current_user.companies.find(params[:company_id]).products.build(product_params)

    if @product.save
      render json: {
        status: { code: 200, message: "Product created sucessfully." },
        data: ProductSerializers.new(@product).serializable_hash,
      }, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def show
    @company = Company.find(params[:company_id])
    @product = @company.products.find(params[:id])
    render json: {
             data: ProductSerializers.new(@product).serializable_hash,
           }, status: :ok
  end

  def update
    @product = Product.find(params[:id])

    if @product.company.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @product.update(product_params)
      render json: {
        status: { code: 200, message: "Product updated sucessfully." },
        data: ProductSerializers.new(@product).serializable_hash,
      }, status: :ok
    else
      render json: {
               status: { message: "Product couldn't be updated successfully." },
               errors: @product.errors.full_messages.to_sentence,
               status: :unprocessable_entity,
             }
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.company.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @product.destroy
      render json: {
        message: "Product deleted sucessfully.",
        data: ProductSerializers.new(@product).serializable_hash,
      }, status: :created
    else
      render json: {
               status: { message: "Product couldn't be deleted successfully." },
               errors: @product.errors.full_messages.to_sentence,
               status: :unprocessable_entity,
             }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :product_url)
  end
end
