require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  setup do
    Note.drop
  end

  teardown do
  end

  test "create show update and delete one note" do
    note_attr={name: "note1", comment: "note1 for test"}
    assert note = Note.create_one(note_attr)[:objid], "create one note and save to db"
    assert_equal Note.find_one({_id: note})["name"], note_attr[:name]
    assert_equal Note.find_one({_id: note})["comment"], note_attr[:comment]
    #TODO: update
    #TODO, need essential filelds when update note
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
end

