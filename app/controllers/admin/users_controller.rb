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

    def destroy
      user = User.find(params[:id])
      if user.destroy
        flash[:notice] = "Successfully deleted #{user.username}"
        @users = User.all.order(username: :asc)
        render "index"
      elsif !user.destroy
        flash[:error] = "Can't delete that user at this time"
        @users = User.all.order(username: :asc)
        render "index"
      end
    end
  end
end
