class LabelsController < ApplicationController
  def index
    @note = Note.find_one({_id: BSON::ObjectId(params[:note_id])})
    @labels = @note["labels"]
  end

  def new
    @note_id = params[:note_id]
  end

  def create
    note_id = params[:note_id]
    label = Note.create_one_label(note_id, params[:label])
    if label[:lid]
      redirect_to note_labels_path(@note_id), notice: label[:message]
    else
      flash[:error] = label[:message]
      redirect_to new_note_label_path(@note_id)
    end
  end

  def edit
    @note = Note.find_one({_id: BSON::ObjectId(params[:note_id])})
    #TODO: improve the performance
    @label = @note["labels"].each do |label|
      label if label[:lid] == BSON::ObjectId(params[:id])
    end
  end

  def update
    @note_id = params[:note_id]
    if Note.update_one_label(params[:id], params[:label])
      redirect_to note_labels_path(@note_id), notice: "label successfully updated!"
    else
      flash[:error] = "label update failed!"
      redirect_to edit_note_label_path(@note_id)
    end
  end

  def show
    @note = Note.find_one({_id: BSON::ObjectId(params[:note_id])})
    #TODO: improve the performance
    @label = @note["labels"].each do |label|
      label if label["lid"] == BSON::ObjectId(params[:id])
    end
  end

  def destroy
    @note_id = params[:note_id]
    @label_id = params[:id]
    if Note.delete_one_label(@note_id, @label_id)
      redirect_to note_labels_path(@note_id), notice: "delete label successed!"
    else
      flash[:error] = "delete label failed!"
      redirect_to note_labels_path(@note_id)
    end
  end
end
