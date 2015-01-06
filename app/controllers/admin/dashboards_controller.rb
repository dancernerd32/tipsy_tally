module Admin
  class DashboardsController < ApplicationController

    before_filter :authenticate_user!
    before_filter do
      if current_user.role.downcase != "admin"
        flash[:error] = "You are not authorized to view that page"
        redirect_to root_path
      end
    end

    def show
    end
  end
end
