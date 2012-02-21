# encoding: UTF-8

require 'test_helper'

class RecordTest < ActiveSupport::TestCase

  setup do
  end

  teardown do
  end

  test "create show update and delete one record" do
    note_attr={name: "note1", comment: "note1 for test"}
    label_attr1={name: "label1", comment: "label1 of note1 for test"}
    label_attr2={name: "label2", comment: "label2 of note1 for test"}
    assert note_id = Note.create_one(note_attr)[:objid].to_s
    assert label_id1 = Note.create_one_label(note_id,label_attr1)[:lid].to_s
    assert label_id2 = Note.create_one_label(note_id,label_attr2)[:lid].to_s
    record_attr={label_id1=>"content1", label_id2=>"content1中文字符"}
    assert record_id = Record.create_one(note_id, record_attr)[:objid]
    #TODO assert show
    record_attr2={label_id1=>"content2", label_id2=>"content2-日本語とテスト"}
    assert record_id = Record.update_one(record_id.to_s, record_attr2)[:objid]
    #TODO assert data persistence of attr and in_db
    assert Record.delete_one(record_id.to_s)
    assert_nil Record.find_one({_id: record_id})
  end

  test "create record when data not valid" do
    assert false, "this feature to be done."
  end

  test "update record when data not valid" do
    assert false, "this feature to be done."
  end

end

