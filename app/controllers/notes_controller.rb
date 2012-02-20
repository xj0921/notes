class NotesController < ApplicationController
  def index
    @notes = Note.find
  end

  def new
  end

  def create
    note = Note.create_one(params[:note])
    if note[:objid]
      redirect_to notes_path, notice: note[:message]
    else
      flash[:error] = note[:message]
      redirect_to new_note_path
    end
  end

  def edit
    #puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    #puts @note = Note.find_one({_id: BSON::ObjectId(params[:nid])})["_id"]
    #puts "#############################"
  end

  def update
    redirect_to notes_path, notice: "note successfully updated!"
  end

  def show
    #@note = Note.find_one({_id: BSON::ObjectId(params[:nid])})
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

