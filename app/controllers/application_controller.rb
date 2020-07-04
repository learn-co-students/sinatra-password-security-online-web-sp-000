#Basic Authentication system for a user without storing plain text passwords in our database! 

require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

#get "/" renders an index.erb file with links to signup or login.
#index.erb
	get "/" do
		erb :index
	end

#renders a form to create a new user (w username and pass)
#signup.erb
	get "/signup" do
		erb :signup
	end

#make a new instance of user class w/ username and pass from params.
	post "/signup" do
 user = User.new(:username => params[:username], :password => params[:password])
#redirect to login once the user is saved
#redirect to failure if the user cannot be saved.
 if user.save
    redirect "/login"
  else
    redirect "/failure"
  end
end

#renders a form for logging in login.erb
	get "/login" do
		erb :login
	end

#find the user by username.
#IS THE USER AUTHENTICATED? if yes, set session user id to redirect to success route.
#if not, failure, try again
#did we find the user by that username? success or failure?
post "/login" do
user = User.find_by(:username => params[:username])
if user && user.authenticate(params[:password])
	session[:user_id] = user.id
	redirect "/success"
else
	redirect "/failure"
end
end

#displayed once a user logs in
#success.erb
	get "/success" do
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

#failure.erb
#accessed if there is an error logging in or signing up
	get "/failure" do
		erb :failure
	end

#clears the session data and redirects to the homepage
	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		#returns true or false based on the presence of a session[:user_id]
		def logged_in?
			!!session[:user_id]
		end

# returns the instance of the logged in user, based on the session[:user_id].
		def current_user
			User.find(session[:user_id])
		end
	end

end
