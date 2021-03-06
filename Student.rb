#DataMapper.setup(:default, "sqlite3://C:/Users/ybansal1/Assignment_2/student.db")
#DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
DataMapper::setup(:default, ENV['DATABASE_URL'] || "postgres://#{Dir.pwd}/development.db")
#DataMapper::setup(:default, ENV['postgres://hvgtkgabvdtymn:106ea6dc0f3db633a3efcbcb1c3627429d2fe390abb21383ed0d2db56648c84b@ec2-174-129-224-33.compute-1.amazonaws.com:5432/d4a59oisbr0t9n'] || "sqlite3://#{Dir.pwd}/development.db")

class Student
  include DataMapper::Resource
  property :student_id, Serial
  property :student_firstname, String
  property :student_lastname, String
  property :student_birthdate, String
  property :student_address, String
  
  
end

DataMapper.finalize
DataMapper.auto_upgrade!



