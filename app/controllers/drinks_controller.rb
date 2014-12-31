class DrinksController < ApplicationController
  def new
    authenticate_user!
    @drink = Drink.new
    @liquors = Liquor.all
    @liquors.each do |liquor|
      @drink.drink_liquors.build(liquor_id: liquor.id)
    end
  end

  def create
    @drink = Drink.new(drink_params)
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
    params.require(:drink).permit(:name,:description,:alcoholic)
  end
end
