module Admin
  class UsersController < ApplicationController

    before_filter :authenticate_user!
    before_filter do
      if current_user.role.downcase != "admin"
        flash[:error] = "You are not authorized to view that page"
        redirect_to root_path
      end
    end

    def index
      @users = User.all.order(username: :asc)
    end

  end
end
