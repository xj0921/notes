# encoding: UTF-8
class User
  def self.coll
    NoteDB.collection "users"
  end
  
  def self.find_one
    coll.find_one()
  end
end
