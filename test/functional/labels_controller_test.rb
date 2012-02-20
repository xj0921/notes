require 'test_helper'

class LabelsControllerTest < ActionController::TestCase
  setup do
    Note.drop
    note_attr={name: "note1", comment: "note1 for test"}
    label_attr={name: "label1", comment: "label1 of note1 for test"}
    @note_id = Note.create_one(note_attr)[:objid].to_s
    @label_id = Note.create_one_label(@note_id,label_attr)[:lid].to_s
  end

  teardown do
  end

  test "should get index" do
    get :index, note_id: @note_id
    assert_response :success
    assert_not_nil assigns(:labels)
  end

  test "should get new" do
    get :new, note_id: @note_id
    assert_response :success
    assert_not_nil assigns(:note_id)
  end

  test "should get edit" do
    get :edit, note_id: @note_id, id: @label_id
    assert_response :success
    #TODO: assert_not_nil assigns(:label)
    #TODO: some more assigns?
  end

  test "should get show of label info" do
    get :show, :note_id => @note_id, :id => @label_id
    assert_response :success
    assert_not_nil assigns(:note)
    assert_not_nil assigns(:label)
  end

  test "create new label and update and delete" do
    label_params = {label: {name: "label1", comment: "label1 of note1 for controller test"}, note_id: @note_id}
    assert_difference('Note.find_one({_id: BSON::ObjectId(@note_id)})["labels"].count', 1) do
      post :create, label_params
    end
    assert_redirected_to note_labels_path(@note_id)
    assert_equal "label successfully created!", flash[:notice]

    #TODO: update test

    assert_difference('Note.find_one({_id: BSON::ObjectId(@note_id)})["labels"].count', -1) do
      delete :destroy, note_id: @note_id, id: @label_id
    end
    assert_redirected_to note_labels_path(@note_id)
    assert_equal "delete label successed!", flash[:notice]
  end

  test "create new label failed for invalid data" do
    label_params = {label: {name: "", comment: "label1 of note1 for controller test"}, note_id: @note_id}
    assert_no_difference('Note.find_one({_id: BSON::ObjectId(@note_id)})["labels"].count') do
      post :create, label_params
    end
    assert_redirected_to new_note_label_path(@note_id)
    #TODO: assert template new
    assert_not_nil flash[:error]
  end

  test "update label info" do
  end
end


#######################################################################

=begin
class NotesControllerTest < ActionController::TestCase

  test "update note info" do
    assert false, "this feature to be done."
  end
end
=end
