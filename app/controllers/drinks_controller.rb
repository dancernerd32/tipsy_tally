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

  def edit
    @drink = Drink.find(params[:id])
    @liquors = Liquor.all
  end

  def update
    @drink = Drink.find(params[:id])
    @drink.update(drink_params)
    if @drink.save
      flash[:notice] = "Successfully updated drink"
      redirect_to drink_path(@drink)
    end
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
