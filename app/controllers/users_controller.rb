class UsersController < ApplicationController

  def index
    @users = User.coll.find()
  end

  def new
  end

  def create
    #TODO: validate before create and save to db
    if User.create_one(params[:user])
      redirect_to users_path, notice: "user successfully created!"
    else
      render 'new', notice: "user create failed!"
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

