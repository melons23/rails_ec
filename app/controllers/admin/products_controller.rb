class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
                  .order(created_at: :desc)
                  .with_attached_image
                  .page(params[:page])
                  .per(30)
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: "#{@product.name}を登録しました。"
    else
      flash.now[:danger] = I18n.t('item.create_error')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "#{@product.name}を更新しました。"
    else
      flash.now[:danger] = I18n.t('item.edit_error')
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    if @product.destroy
      redirect_to admin_products_path, notice: "#{@product.name}を削除しました。"
    else
      flash[:danger] = I18n.t('item.delete_error')
      render 'show'
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
