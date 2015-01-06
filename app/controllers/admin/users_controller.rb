module Admin
  class UsersController < ApplicationController

    before_filter :authenticate_user!

    def index
      @users = User.all.order(username: :asc)

      if current_user.role.downcase != "admin"
        flash[:error] = "You are not authorized to view that page"
        redirect_to root_path
      end
    end

  end
end
