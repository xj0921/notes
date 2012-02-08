# encoding: UTF-8
class User
  #include ActiveModel::Validations
  #include ActiveModel::MassAssignmentSecurity
  #validates_presence_of :email, :password, :password_confirmation, :on=>:create_one
  #validates_confirmation_of :password

  #attr_accessor :email, :name, :password, :password_confirmation
  #attr_accessible :email, :name, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  def self.coll
    NoteDB.collection "users"
  end

  def self.create_one(user_attr)
    # validate_user_attr
    return false if user_attr[:email] == nil or user_attr[:email] == ""


    user_attr[:salt] = BCrypt::Engine.generate_salt
    user_attr[:encrypted_password] = BCrypt::Engine.hash_secret(user_attr[:password], user_attr[:salt])

    user_attr.delete :password
    user_attr.delete :password_confirmation
    user_attr[:created_at] = Time.now
    user_attr[:updated_at] = Time.now
    User.coll.insert(user_attr)
  end

  def self.authenticate(email,submitted_password)
    user = User.coll.find_one(email: email)
    (user && user["encrypted_password"] == BCrypt::Engine.hash_secret(submitted_password,user["salt"])) ? user : nil
  end

  private
  def validate_user_attr(user_attr)
  end

end
