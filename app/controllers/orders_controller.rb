class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    # Створення нового замовлення
    @order = Order.new
    @cart_items = current_user.cart.cart_items
  end

  def create
    # Створення замовлення з даними користувача та товарів з кошика
    @order = Order.new(order_params)
    @order.user = current_user

    # Додаємо продукти з кошика в замовлення
    current_user.cart.cart_items.each do |cart_item|
      @order.order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end

    # Якщо замовлення збережене, очищаємо кошик та переходимо на сторінку підтвердження
    if @order.save
      current_user.cart.cart_items.destroy_all
      redirect_to order_path(@order), notice: "Your order has been placed successfully."
    else
      render :new
    end
  end

  def show
    # Перегляд замовлення
    @order = Order.find(params[:id])
  end

  private

  # Валідація параметрів для замовлення
  def order_params
    params.require(:order).permit(:phone_number, :delivery_method, :payment_method, :delivery_address)
  end
end
