class CartsController < ApplicationController
  def index
    @cart_items = cart_items
    @subtotal = calculate_total
  end

  def new
    @cart_items = CartItem.new
  end

  def create
    @cart_items = CartItem.create(product_params)

    if @cart_items.save
      redirect_to request.referer, notice: I18n.t('cart.create')
    else
      redirect_to product_path(params[:product][:id]), danger: I18n.t('cart.create_error')
    end
  end

  def destroy
    @cart_items = current_cart.cart_items
                              .joins(:product)
                              .where(cart_id: current_cart.id, product_id: params[:id])

    if @cart_items.destroy_all
      redirect_to carts_path, notice: I18n.t('cart.delete')
    else
      flash[:danger] = I18n.t('cart.delete_error')
      render 'show'
    end
  end

  private

  def product_params
    params.require(:product).permit(:quantity).merge(cart_id: current_cart.id, product_id: params[:product][:id])
  end

  def cart_items
    current_cart.cart_items.select('products.id AS product_id,
                        MAX(cart_items.created_at) AS created_at,
                        products.name AS name, MAX(products.price) AS price,
                        SUM(cart_items.quantity) AS item_total')
                .joins(:product)
                .group('products.id, products.name')
                .order('created_at desc')
  end

  def calculate_total
    current_cart.cart_items
                .joins(:product)
                .sum('cart_items.quantity * products.price')
  end
end
