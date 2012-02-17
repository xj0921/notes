class NotesController < ApplicationController
  def index
    @notes = Note.find
  end

  def new
  end

  def create
    note = Note.create_one(params[:note])
    if note["objid"]
      redirect_to notes_path, :notice: note[:message]
    else
      flash[:error] = note[:message]
      redirect_to new_note_path
    end
  end

  def edit
  end

  def update
  end

  def show
    @note = Note.find_one({_id: BSON::ObjectId(params[:nid])})
  end

  def destroy
    if Note.delete_one(params[:nid])
      redirect_to notes_path, notice: "delete note successed!"
    else
      flash[:error] = "delete note failed!"
      redirect_to notes_path
    end
  end
end

######################################################################
class UsersController < ApplicationController

  def create
    user_create = User.create_one(params[:user])
    if user_create[:objid]
      redirect_to new_session_path, notice: user_create[:message]
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

