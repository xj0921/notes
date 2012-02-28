class UsersController < ApplicationController

  def home
  end

  def index
    @users = User.find.page(params[:page].to_i).to_a
    @pages=(User.find.to_a.count.to_f / 10).ceil
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

  def create_fnote
    User.create_fnote(session[:user_id],params[:note_id])
    redirect_to :back
  end

  def destroy_fnote
    User.del_fnote(session[:user_id],params[:note_id])
    redirect_to :back
  end
end

