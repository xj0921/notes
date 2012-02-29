# encoding: UTF-8
require "mongo_helper"

Record = NoteDB.collection "records"

def Record.create_one(note_id, record)
  val = validate_save_record(record); return val unless val[:objid]

  record[:nid] = BSON::ObjectId(note_id)
  record[:created_at] = record[:updated_at] = Time.now
  record_id = Record.insert(record)
  return {objid: record_id, message: "record successfully added!"}
end

def Record.update_one(record_id, record)
  val = validate_save_record(record); return val unless val[:objid]

  record[:updated_at] = Time.now
  Record.update({_id: BSON::ObjectId(record_id)}, {'$set'=>record})
  return {objid: record_id, message: "record successfully updated!"}
end

def Record.delete_one(record_id)
  Record.remove({_id: BSON::ObjectId(record_id)})
end

private
def validate_save_record(record)
  err_msg=[]
  #TODO: validation of record when create and update
  #if record[:name] == "" or record[:name] == nil
  #  err_msg << "名称不能为空"
  #end
  err_msg.empty? ? {objid: true, message: "no error"} : {objid: nil, message: err_msg}
end

