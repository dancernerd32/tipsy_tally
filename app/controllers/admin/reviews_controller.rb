module Admin
  class ReviewsController < ApplicationController

    before_filter :authenticate_user!
    before_filter do
      if current_user.role.downcase != "admin"
        flash[:error] = "You are not authorized to view that page"
        redirect_to root_path
      end
    end

    def destroy
      review = Review.find(params[:id])
      if review.destroy
        flash[:notice] = "Successfully Deleted Review"
        redirect_to drink_path(review.drink)
      else
        render drink_path(review.drink)
      end
    end
  end
end
