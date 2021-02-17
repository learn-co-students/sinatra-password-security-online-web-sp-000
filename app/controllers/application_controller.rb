require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do #renders index.erb
		erb :index # view has links to signup or login
	end

	get "/signup" do # renders a form to create a new user
		erb :signup # view includes field for username and password
	end

	post "/signup" do # even though our database has a column called password_digest, we still access the attribute of password. This is given to us by has_secure_password
		user = User.new(:username => params[:username], :password => params[:password])

		if user.save # because our user has has_secure_password, we won't be able to save this to the database unless our user filled out the password field.
			redirect "/login" # calling user.save will return true if the user was persisted
		else
			redirect "/failure" # will return false if the user can't be persisted
		end
	end

	get "/login" do # renders a form for logging in
		erb :login
	end

	post "/login" do
		user = User.find_by(:username => params[:username]) # find the user by username
		if user && user.authenticate(params[:password]) # did we find a User with that username? and is that User authenticated?
			session[:user_id] = user.id
			redirect "/success" # if we did redirect to success
		else
			redirect "/failure" # if not redirect to failure
		end
	end

	get "/success" do # renders success.erb page, which should be displayed once a user successfully logs in
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do # renders failure.erb page. This will be accessed if there is an error loggin in or signing up
		erb :failure
	end

	get "/logout" do # clears the session data and redirects to the homepage
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in? # returns true or false based on the presence of a session[:user_id]
			!!session[:user_id]
		end

		def current_user # returns the instance of the logged in user, based on the session[:user_id]
			User.find(session[:user_id])
		end
	end

end
