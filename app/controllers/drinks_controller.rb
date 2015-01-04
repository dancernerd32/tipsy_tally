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
  end

  def edit
    @drink = Drink.find(params[:id])
    @liquors = Liquor.all
  end

  def update
    drink = Drink.find(params[:id])
    if drink.update(drink_params)
      flash[:notice] = "Successfully updated drink"
      redirect_to drink_path(drink)
    else
      @liquors = Liquor.all
      @drink = Drink.create(drink_params)
      render "edit"
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
