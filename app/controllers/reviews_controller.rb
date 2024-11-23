class ReviewsController < ApplicationController
    def create
      @product = Product.find(params[:product_id])
      @review = @product.reviews.build(review_params)
      @review.user = current_user
  
      if @review.save
        redirect_to @product, notice: "Review successfully added."
      else
        redirect_to @product, alert: "Failed to add review."
      end
    end
  
    private
  
    def review_params
      params.require(:review).permit(:rating, :content)
    end
  end
  