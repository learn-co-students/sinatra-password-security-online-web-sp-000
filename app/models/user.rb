#has_secure_password is a macro that adds additional methods to your app.
#the #authenticate method is added and validates password match

class User < ActiveRecord::Base
	has_secure_password
end
