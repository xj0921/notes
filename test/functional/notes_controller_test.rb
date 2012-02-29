# encoding: UTF-8

require 'test_helper'

class NotesControllerTest < ActionController::TestCase

  setup do
    Note.drop
    note_attr={name: "note1", comment: "note1 for test"}
    @note_id = Note.create_one(note_attr)[:objid].to_s
  end

  teardown do
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @note_id
    assert_response :success
    assert_not_nil assigns(:note)
  end

  test "should get show of note info" do
    get :show, id: @note_id
    assert_response :success
    assert_not_nil assigns(:note)
  end

  test "create new note and update and delete" do
    note_params = {note: {name: "note1", comment: "note1 for controller test"}}
    assert_difference('Note.count') do
      post :create, note_params
    end
    assert_redirected_to notes_path
    assert_equal "note successfully created!", flash[:notice]

    #TODO: update test

    note_id = Note.find_one["_id"].to_s
    assert_difference('Note.count', -1) do
      delete :destroy, id: note_id
    end
    assert_redirected_to notes_path
    assert_equal "delete note successed!", flash[:notice]
  end

  test "create new note failed for invalid data" do
    note_params = {note: {comment: "note1 for controller test"}}
    assert_no_difference('Note.count') do
      post :create, note_params
    end
    assert_redirected_to new_note_path
    #TODO: assert_template "new"
    assert_not_nil flash[:error]
  end

  test "update note info" do
    assert false, "this feature to be done."
  end

  test "click page1 when notes=11" do
    #note_params = {note: {name: "note1", comment: "note1 for controller test"}}
    #TODO: add data using controller post method
    #10.times {post :create, note_params}
    10.times {Note.create_one({name: "note1", comment: "note1 for test"})}
    get :index, page: 1 
    assert_response :success
    assert_not_nil assigns(:notes)
    assert_not_nil assigns(:pages)
    assert_equal assigns(:notes).count, 10
    assert_equal assigns(:pages), 2
  end

  test "click page2 when notes=11" do
    #note_params = {note: {name: "note1", comment: "note1 for controller test"}}
    #TODO: add data using controller post method
    #10.times {post :create, note_params}
    10.times {Note.create_one({name: "note1", comment: "note1 for test"})}
    get :index, page: 2 
    assert_response :success
    assert_not_nil assigns(:notes)
    assert_not_nil assigns(:pages)
    assert_equal assigns(:notes).count, 1
    assert_equal assigns(:pages), 2
  end
end

