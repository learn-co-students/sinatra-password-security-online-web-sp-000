class User < ActiveRecord::Base
	has_secure_password
end


post 'login' do 
	user= User.find_by(:username => params[:username])
	session[:user_id]
	if user && user.athenticate(params[:password])
		redirect '/sucsess'
	else 
		redirect '/fail'	
		end
	end
