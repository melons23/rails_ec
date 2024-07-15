class ProductsController < ApplicationController
  def index 
    @products = Product.with_attached_image.page(params[:page]).per(20)
  end

  def show
    @product = Product.find(params[:id])

    @related_products = Product.where.not(id: @product.id).with_attached_image.limit(4).order(created_at: "DESC")
  end

  private
  
  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end
end
