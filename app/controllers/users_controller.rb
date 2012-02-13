class UsersController < ApplicationController

  def index
    @users = User.find()
  end

  def home
  end

  def new
  end

  def create
    user_create = User.create_one(params[:user])
    if user_create[:status]
      redirect_to new_session_path, notice: "user successfully created,please login."
    else
      flash[:error] = user_create[:message]
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

