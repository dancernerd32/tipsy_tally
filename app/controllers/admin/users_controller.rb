module Admin
  class UsersController < ApplicationController
    
    before_filter :authenticate_user!

    def index
      @users = User.all.order(username: :asc)
    end

  end
end
