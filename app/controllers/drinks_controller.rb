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
    @drink.save
    if @drink.save
      flash[:notice] = "Successfully created new drink"
      redirect_to drink_path(@drink)
    else
      render "new"
    end
  end

  def show
    @drink = Drink.find(params[:id])
  end

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
