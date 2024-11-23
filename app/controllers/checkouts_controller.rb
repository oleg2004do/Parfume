class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
    @cart_items = current_user.cart.cart_items
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    # Додаємо всі товари з кошика до замовлення
    current_user.cart.cart_items.each do |cart_item|
      @order.order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end

    if @order.save
      # Очищуємо кошик після успішного оформлення замовлення
      current_user.cart.cart_items.destroy_all
      redirect_to order_path(@order), notice: 'Your order has been placed successfully.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:phone_number, :delivery_method, :payment_method, :delivery_address)
  end
end
