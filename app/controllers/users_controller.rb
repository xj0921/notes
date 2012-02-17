class UsersController < ApplicationController

  def home
  end

  def index
    @users = User.find
  end

  def new
  end

  def create
    user = User.create_one(params[:user])
    if user[:objid]
      redirect_to new_session_path, notice: user[:message]
    else
      flash[:error] = user[:message]
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
      redirect_to users_path, notice: 'user information updated!'
  end

  def show
  end
end

