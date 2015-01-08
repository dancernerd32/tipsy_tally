class DrinksController < ApplicationController
  def new
    authenticate_user!
    @drink = Drink.new
    @liquors = Liquor.all
  end

  def create
    @drink = Drink.new(drink_params)
    @liquors = Liquor.all
    @drink.user = current_user
    if @drink.save
      flash[:notice] = "Successfully created new drink"
      redirect_to drink_path(@drink)
    else
      render "new"
    end
  end

  def show
    @drink = Drink.find(params[:id])
    @reviews = @drink.reviews
    @review = Review.new
    @review.drink = @drink
  end

  def edit
    @drink = Drink.find(params[:id])
    @liquors = Liquor.all
    if !signed_in?
      flash[:error] = "You must be signed in to do that"
      redirect_to drink_path(@drink)
    elsif @drink.user != current_user
      flash[:error] = "You cannot edit someone else's drink"
      redirect_to drink_path(@drink)
    end
  end

  def update
    drink = Drink.find(params[:id])
    if drink.update(drink_params)
      flash[:notice] = "Successfully updated drink"
      redirect_to drink_path(drink)
    else
      @liquors = Liquor.all
      if drink.alcoholic?
        @drink = Drink.create(drink_params)
      else
        @drink = Drink.new(drink_params)
        @drink.alcoholic = false
        @drink.save
      end
      render "edit"
    end
  end

  def destroy
    flash[:notice] = "Successfully deleted drink"
    redirect_to drinks_path
  end

  def index
  end

  private

  def drink_params
    params.require(:drink).
      permit(
        :name,
        :description,
        :alcoholic,
        liquor_ids: []
        )
  end
end
