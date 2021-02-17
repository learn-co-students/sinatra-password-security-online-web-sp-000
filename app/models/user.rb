class User < ActiveRecord::Base
	has_secure_password # Active Record macro is being called just like a normal ruby method. It works in conjunction with a gem call bcrypt and gives us all of those abilities in a secure way that doesn't actually store the plain text password in the database.
    # we validate password match by using a method called authenticate on our User model.
    # we do not have to write this method ourselves. Rather when we added the line above to User
    # we told Ruby to add an authenticate method to our class invisibly when the program runs.
end