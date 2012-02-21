class RecordsController < ApplicationController
  def index
    @note_id = params[:note_id]
    @note = Note.find_one({_id: BSON::ObjectId(@note_id)})
    @records = Record.find({nid: BSON::ObjectId(@note_id)})
  end

  def new
    @note_id = params[:note_id]
    @note = Note.find_one({_id: BSON::ObjectId(@note_id)})
  end

  def create
    @note_id = params[:note_id]
    record = Record.create_one(@note_id, params[:record])
    if record[:objid]
      redirect_to note_records_path(@note_id), notice: record[:message]
    else
      flash[:error] = record[:message]
      redirect_to new_note_record_path(@note_id)
    end
  end

  def edit
    @note = Note.find_one({_id: BSON::ObjectId(params[:note_id])})
    @record = Record.find_one({_id: BSON::ObjectId(params[:id])})
  end

  def update
    @note_id = params[:note_id]
    record = Record.update_one(params[:id], params[:record])
    if record[:objid]
      redirect_to note_records_path(@note_id), notice: record[:message]
    else
      flash[:error] = "record update failed!"
      redirect_to :back
    end
  end

  def show
    @note = Note.find_one({_id: BSON::ObjectId(params[:note_id])})
    @record = Record.find_one({_id: BSON::ObjectId(params[:id])})
  end

  def destroy
    @note_id = params[:note_id]
    @record_id = params[:id]
    if Record.delete_one(@record_id)
      redirect_to note_records_path(@note_id), notice: "delete record successed!"
    else
      flash[:error] = "delete record failed!"
      redirect_to note_records_path(@note_id)
    end
  end
end

