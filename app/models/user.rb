#has_secure_password is a macro that adds additional methods to your app.
#the #authenticate method is added and will check for correct password

class User < ActiveRecord::Base
	has_secure_password
end