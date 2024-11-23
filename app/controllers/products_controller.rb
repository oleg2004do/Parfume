class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def authorize_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user&.admin?
  end

  def index
    @products = Product.all.order(created_at: :desc) # Додаємо сортування за останніми створеними продуктами
  end

  def show
    if @product.nil?
      redirect_to products_path, alert: "Product not found."
    end
  end

  def new
    @product = Product.new
    render 'new_product'
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Product successfully created."
    else
      render :new, alert: "Failed to create product. Please check the form."
    end
  end

  def edit
    # Використовується set_product, тому додатково нічого не потрібно
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product successfully updated."
    else
      render :edit, alert: "Failed to update product. Please check the form."
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      redirect_to root_path, notice: 'Product successfully deleted.'  # Перенаправлення на головну сторінку
    else
      redirect_to products_path, alert: 'Failed to delete product.'  # У разі помилки перенаправляємо на сторінку продуктів
    end
  end

  private

  # Викликається перед show, edit, update, destroy
  def set_product
    @product = Product.find_by(id: params[:id])
    redirect_to products_path, alert: "Product not found." if @product.nil?
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
