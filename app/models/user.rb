class User < ActiveRecord::Base
	has_secure_password
    #active record macro, works with bcrypt and gives us abilities to create methods without storing plaintext in database
end