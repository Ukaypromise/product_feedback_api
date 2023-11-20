class Api::V1::ProductsController < ApplicationController

  def index
    @products = Product.all
    render json: {
      data: @products
    }
  end

  def create
    @product = current_user.companies.find(params[:company_id]).products.build(product_params)

    if @product.save
      # render json: @product, status: :created
      render json: {
        status: { code: 200, message: "Product created sucessfully." },
        data: ProductSerializers.new(@product).serializable_hash,
      }, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :product_url,)
  end
end
