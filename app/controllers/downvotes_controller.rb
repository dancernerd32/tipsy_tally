class DownvotesController < ApplicationController
  def create
    authenticate_user!
    review = Review.find(params[:review_id])
    review.downvote(current_user.id, review.id)
    flash[:notice] = "Voted Successfully"
    redirect_to drink_path(params[:drink_id])
  end
end
