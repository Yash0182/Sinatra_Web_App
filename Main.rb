require 'sinatra'
require 'sinatra/reloader'
require 'dm-core'
require 'dm-migrations'
require './Student.rb'
require './Comment.rb'
require 'dm-timestamps'


class Main
	puts "Connected..."
end

configure do
	enable :sessions
	set :username, "yash"
	set :password, "bansal"
end

configure :development do
 #setup sqlite database
end

configure :production do
 #setup ENV[...] database
end


helpers do	#helper method to check for admin all the time
   def admin?
   session[:admin]
   end
end



#student's Home Page also list all students first name

get '/students/?' do
  @students = Student.all
  erb :students
end

#Add New Student
get '/students/new/?' do
	if admin? 
		@student = Student.new
		erb :new_student
	else
		erb :PleaseLogin
end
end

post '/students/add' do  
  student = Student.create(params[:student])
  
  student.save
  redirect to("/students")
end


#Search for a student
get '/students/searchget/?' do
  erb :show_student_search
end

post '/students/search' do  
  @student = Student.get(params[:student_id])
  if @student==nil
  erb :No_Record_Found
  else
  erb :show_student
  end
end

#Edit a student's detail

get '/students/edit' do
  if admin? 
  erb :edit_student_get
  else
  erb :PleaseLogin
  end
end

post '/students/editpost' do
	@students = Student.get(params[:student_id])
	if @students==nil
	erb :No_Edit_Found
	else
	erb :student_editform
	end
end

put '/students/add/:id' do
	@student = Student.get(params[:id])
	print "Hello Yash"
	print "#{@student.student_id}"
	@student.update(params[:student])
	@student.save
	redirect to("/students")
end

#delete student record
get '/students/delete' do
  if admin?
  erb :delete_student
  else
  erb :PleaseLogin
  end
end

post '/students/deleterecord' do
	@students = Student.get(params[:student_id])
	if @students==nil
	erb :No_Delete_Found
	else
	@students.destroy
	redirect to('/students')
	end
	
end

#comment section

get '/comment/?' do
	@comments = Comment.all
	erb :comments
end


get '/createcomment' do
	@commentcreate = Comment.new
	erb :commentcreate
end

post '/comment/create' do
	comment = Comment.create(params[:commentcreate])
	comment.save
	redirect to('/comment')
end

get '/comments/:comment_id' do
	@comments = Comment.get(params[:comment_id])
	erb :commentdetails
end

get '/home/?' do
	"Welcome to the home page"
	erb :home
end

get '/about/?' do
	"Welcome to the about page"
	erb :about
end

get '/contacts/?' do
	"Welcome to my contacts"
	erb :contacts
end

get '/show_video' do
	erb :video_show
end

get '/login' do
	erb :login_page
end

post '/login/?' do
	if params[:username]==settings.username && params[:password]==settings.password
	session[:admin]=true
	erb :logout_view
	else
	erb :tryagain
	end
end

get '/logout_view' do
	erb :logout_view
end

get '/logout' do
	session[:admin]=false
	session.clear
	redirect to ('/') 
end

get '/' do
	erb :main_view
end
not_found do
	erb :notfound
end