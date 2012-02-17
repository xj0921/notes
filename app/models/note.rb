# encoding: UTF-8

Note = NoteDB.collection "notes"

def Note.create_one(note)
  val = validate_create_note(note); return val unless val[:objid]

  note[:created_at] = note[:updated_at] = Time.now
  nid = Note.insert(note)
  return {objid: nid, message: "note successfully created!"}
end

def Note.update_one(note)
end

def Note.delete_one(note)
  #TODO: delete releated data (note_info,relations,records)
  Note.remove({_id: BSON::ObjectId(note)})
end

private
def validate_create_note(note)
  #TODO: 空名称不能存入，系统保留不能存入（_开头的名称）
  err_msg=[]
  if note[:name] == "" or note[:name] == nil
    err_msg << "名称不能为空"
  elsif note[:name] =~ /^_/ 
    err_msg << "_开头的名称为系统保留，请使用其它名称。"
  else
  end
  err_msg.empty? ? {objid: true, message: "no error"} : {objid: nil, message: err_msg}
end

def validate_update_note(note)
end

