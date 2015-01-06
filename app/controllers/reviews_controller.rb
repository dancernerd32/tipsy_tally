class ReviewsController < ApplicationController
  def create
    @drink = Drink.find(params[:drink_id])
    @review = @drink.reviews.build(review_params)
    if current_user
      @review.user_id = current_user.id
      if @review.save
        flash[:notice] = "Successfully added your review"
        redirect_to drink_reviews_path(@drink)
      else
        render 'drinks/show'
      end
    else
      flash[:notice] = "You must sign in or sign up to leave a review"
      render 'drinks/show'
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
