class ReviewsController < ApplicationController
  def create
    @drink = Drink.find(params[:drink_id])
    @review = @drink.reviews.build(review_params)
    if current_user
      @review.user_id = current_user.id
      if @review.save
        flash[:notice] = "Successfully added your review"
        redirect_to drink_path(@drink)
        ReviewConfirmation.conf_mail(@drink.user, @drink).deliver_now
      else
        @reviews = Review.where(drink_id: @drink.id).page params[:page]
        render "drinks/show"
      end
    else
      @reviews = Review.where(drink_id: @drink.id).page params[:page]
      flash[:notice] = "You must sign in or sign up to leave a review"
      render "drinks/show"
    end
  end

  def edit
    @drink = Drink.find(params[:drink_id])
    @review = Review.find(params[:id])
    if !signed_in?
      flash[:error] = "You must be signed in to do that"
      redirect_to drink_path(@drink)
    elsif @review.user != current_user
      flash[:error] = "You cannot edit someone else's review"
      redirect_to drink_path(@drink)
    end
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params)
      flash[:notice] = "Review updated successfully!"
      redirect_to drink_path(review.drink)
    end
  end

  def destroy
    review = Review.find(params[:id])
    if review.destroy
      flash[:notice] = "Successfully deleted review"
      redirect_to drink_path(review.drink)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end
end
