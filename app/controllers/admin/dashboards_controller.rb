module Admin
  class DashboardsController < ApplicationController

    before_filter :authenticate_user!

    def show
      if current_user.role.downcase != "admin"
        flash[:error] = "You are not authorized to view that page"
        redirect_to root_path
      end
    end
  end
end
