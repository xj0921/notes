class NotesController < ApplicationController
  def index
    @notes = Note.find.page(params[:page].to_i).to_a
    @pages=(Note.find.to_a.count.to_f / 10).ceil
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
    @note = Note.find_one({_id: BSON::ObjectId(params[:id])})
  end

  def update
    redirect_to notes_path, notice: "note successfully updated!"
  end

  def show
    @note = Note.find_one({_id: BSON::ObjectId(params[:id])})
  end

  def destroy
    if Note.delete_one(params[:id])
      redirect_to notes_path, notice: "delete note successed!"
    else
      flash[:error] = "delete note failed!"
      redirect_to notes_path
    end
  end
end

