require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  setup do
  end

  teardown do
    #Note.drop
  end

  test "create show update and delete one note" do
    note_attr={name: "note1", comment: "note1 for test"}
    assert note = Note.create_one(note_attr)[:objid], "create one note and save to db"
    assert_equal Note.find_one({_id: note})["name"], note_attr[:name]
    assert_equal Note.find_one({_id: note})["comment"], note_attr[:comment]
    #TODO: update
    #TODO: need essential filelds when update note
    assert Note.delete_one(note.to_s)
    assert !Note.find_one({_id: note})
    #TODO: test if note releated data have been deleted
  end

  test "create note when name not presence" do
    note_attr={comment: "note1 for test"}
    assert !Note.create_one(note_attr)[:objid]
  end

  test "create note when name not valid" do
    note_attr={name: "_note1", comment: "note1 for test"}
    assert !Note.create_one(note_attr)[:objid]
  end

  test "update: success and failure" do
    assert false, "essential fields should be filled when update"
  end

  test "create label and update delete it" do
    note_attr={name: "note1", comment: "note1 for test"}
    label_attr={name: "label1", comment: "label1 of note1 for test"}
    assert note_id = Note.create_one(note_attr)[:objid].to_s
    assert label_id = Note.create_one_label(note_id,label_attr)[:lid].to_s
    #TODO: check data persistence of attr and in_db:create
    assert Note.update_one_label(label_id, label_attr)[:lid]
    #TODO: check data persistence of attr and in_db:update
    assert Note.delete_one_label(note_id,label_id)
    #TODO: this record should not exist in db after delete
    #TODO: check all releated data (note_info,records) have been deleted
  end

  test "create label when label_name not presence" do
    note_attr={name: "note1", comment: "note1 for test"}
    label_attr={comment: "label1 of note1 for test"}
    assert note_id = Note.create_one(note_attr)[:objid].to_s
    assert_nil label_id = Note.create_one_label(note_id,label_attr)[:lid]
  end

  test "create label when name not valid" do
    assert false, "this feature to be done."
  end
  
  test "create label when name already existed" do
    assert false, "this feature to be done."
  end

  test "update label failed when data invalid" do
    assert false, "this feature to be done."
  end
end

