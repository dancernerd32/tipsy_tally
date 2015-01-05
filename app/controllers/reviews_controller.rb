class ReviewsController < ApplicationController
  def create
    @drink = Drink.find(params[:drink_id])
    @review = @drink.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "Successfully added your review"
      redirect_to drink_reviews_path(@drink)
    end
  end

  def index
    @drink = Drink.find(params[:drink_id])
    @reviews = @drink.reviews
  end

  private

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end
end
