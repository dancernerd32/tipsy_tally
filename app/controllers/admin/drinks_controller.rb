module Admin
  class DrinksController < ApplicationController

    before_filter :authenticate_user!
    before_filter do
      if current_user.role.downcase != "admin"
        flash[:error] = "You are not authorized to view that page"
        redirect_to root_path
      end
    end

    def index
      @drinks = Drink.all
    end

    def destroy
      drink = Drink.find(params[:id])
      if drink.destroy
        flash[:notice] = "Successfully deleted #{drink.name}" 
        redirect_to admin_drinks_path
      else
        render "index"
      end
    end
  end
end
