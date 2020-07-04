class User < ActiveRecord::Base
	has_secure_password
end

#ActiveRecord macro gives us access to new methods
#Macro: method that when called, creates new methods for you.
#Metaprogramming
#works with bcrypt

#validate password match by using a method called authenticate.
#it is metaprogramming so we cannot see it!
#Authenticate works by:
    #Takes a String as an argument e.g. i_luv@byron_poodle_darling
    #It turns the String into a salted, hashed version (76776516e058d2bf187213df6917a7e)
    #It compares this salted, hashed version with the user's stored salted, hashed password in the database
    #If the two versions match, authenticate will return the User instance; if not, it returns false
