class CartsController < ApplicationController
  before_action :set_cart
  before_action :authenticate_user!, only: [:add_item]

  def show
    @total_price = @cart.cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  def add_item
    product = Product.find(params[:product_id])
    if product.nil?
      redirect_back(fallback_location: products_path, alert: "Product not found.")
      return
    end

    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity ||= 0
    cart_item.quantity += 1

    if cart_item.save
      redirect_back(fallback_location: products_path, notice: "#{product.name} was added to your cart.")
    else
      redirect_to products_path, alert: "Failed to add product to cart."
    end
  end

  def remove_item
    cart_item = @cart.cart_items.find_by(id: params[:id])
    if cart_item
      cart_item.destroy
      redirect_to cart_path 
    else
      redirect_to cart_path, alert: "Item not found."
    end
  end

  private

  def set_cart
    @cart = current_user.cart || Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end
end
