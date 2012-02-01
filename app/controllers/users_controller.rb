class UsersController < ApplicationController

  def index
  end

  def new
  end

  def create
    user_attr = {}
    user_attr[:email]=params[:email]
    user_attr[:password]=params[:password]
    user_attr[:password_confirmation]=params[:password_confirmation]
    if User.create_one(user_attr)
      redirect_to users_path, flash[:notice]=>"one user created!"
    else
      render 'new'
    end
  end
end

