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

	get "/signup" do # renders a form to create a new user. The form includes field for username and password
		erb :signup
	end

	post "/signup" do
		#your code here!
	end

	get "/login" do # renders a form for logging in
		erb :login
	end

	post "/login" do
		#your code here!
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
