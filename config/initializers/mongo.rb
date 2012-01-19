MONGO_CONFIG = YAML.load_file("#{Rails.root}/config/mongo.yml")[Rails.env]

MongoConn = Mongo::Connection.new(MONGO_CONFIG["host"], MONGO_CONFIG["port"])
NoteDB = MongoConn.db(MONGO_CONFIG["database"])

