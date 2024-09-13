# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :admin_url

  helper_method :current_cart, :total_quantity

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def admin_url
    request.fullpath.include?('/admin')
  end

  def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    @cart
  end

  def total_quantity
    @total_quantity = current_cart.cart_items.sum(:quantity)
  end
end
