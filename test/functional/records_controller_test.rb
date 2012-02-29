# encoding: UTF-8

require 'test_helper'

class RecordsControllerTest < ActionController::TestCase
  setup do
    note_attr={name: "note1", comment: "note1 for test"}
    label_attr1={name: "label1", comment: "label1 of note1 for test"}
    label_attr2={name: "label2", comment: "label2 of note1 for test"}
    @note_id = Note.create_one(note_attr)[:objid].to_s
    @label_id1 = Note.create_one_label(@note_id,label_attr1)[:lid].to_s
    @label_id2 = Note.create_one_label(@note_id,label_attr2)[:lid].to_s
    record_attr={@label_id1=>"content1", @label_id2=>"content1中文字符"}
    @record_id = Record.create_one(@note_id, record_attr)[:objid].to_s
  end

  teardown do
  end

  test "should get index" do
    get :index, note_id: @note_id
    assert_response :success
    assert_not_nil assigns(:note_id)
    assert_not_nil assigns(:note)
    assert_not_equal assigns(:note), Mongo::Cursor
    assert_not_nil assigns(:records)
  end

  test "should get new" do
    get :new, note_id: @note_id
    assert_response :success
    assert_not_nil assigns(:note_id)
    assert_not_nil assigns(:note)
    assert_not_equal assigns(:note), Mongo::Cursor
  end

  test "should get edit" do
    get :edit, note_id: @note_id, id: @record_id
    assert_response :success
    assert_not_nil assigns(:note)
    assert_not_equal assigns(:note), Mongo::Cursor
    assert_not_nil assigns(:record)
    assert_not_equal assigns(:record), Mongo::Cursor
  end

  test "should get show of record info" do
    get :show, note_id: @note_id, id: @record_id
    assert_response :success
    assert_not_nil assigns(:note)
    assert_not_equal assigns(:note), Mongo::Cursor
    assert_not_nil assigns(:record)
    assert_not_equal assigns(:record), Mongo::Cursor
  end

  test "create new record and update and delete" do
    record_params={record: {@label_id1=>"content9", @label_id2=>"content9中文字符"}, note_id: @note_id}
    assert_difference('Record.find({nid: BSON::ObjectId(@note_id)}).count', 1) do
      post :create, record_params
    end
    assert_redirected_to note_records_path(@note_id)
    assert_equal "record successfully added!", flash[:notice]

    record_new={record: {@label_id1=>"contentx", @label_id2=>"contentx中文字符"}, note_id: @note_id, id: @record_id}
    put :update, record_new
    #TODO: record_new_db = Record.findxxx
    #TODO: assert_equal record attr in var and db
    assert_equal "record successfully updated!", flash[:notice]

    assert_difference('Record.find({nid: BSON::ObjectId(@note_id)}).count', -1) do
      delete :destroy, note_id: @note_id, id: @record_id
    end
    assert_redirected_to note_records_path(@note_id)
    assert_equal "delete record successed!", flash[:notice]
    assert_nil Record.find_one({_id: @record_id})
  end

  test "create new record failed for invalid data" do
    assert false, "this feature to be done."
  end

  test "update record failed for invalid data" do
    assert false, "this feature to be done."
  end
  
  test "click page1 when records=11" do
    10.times {Record.create_one(@note_id, {@label_id1=>"content1", @label_id2=>"content1中文字符"})}
    get :index, page: 1,note_id: @note_id
    assert_response :success
    assert_not_nil assigns(:note_id)
    assert_not_nil assigns(:note)
    assert_not_nil assigns(:records)
    assert_not_nil assigns(:pages)
    assert_equal assigns(:records).count, 10
    assert_equal assigns(:pages), 2
  end

  test "click page2 when records=11" do
    10.times {Record.create_one(@note_id, {@label_id1=>"content1", @label_id2=>"content1中文字符"})}
    get :index, page: 2,note_id: @note_id
    assert_response :success
    assert_not_nil assigns(:note_id)
    assert_not_nil assigns(:note)
    assert_not_nil assigns(:records)
    assert_not_nil assigns(:pages)
    assert_equal assigns(:records).count, 1
    assert_equal assigns(:pages), 2
  end
end

