#This creates the users table
#Before filling this in, you must create the database in the terminal:
#rake db:migrate NAME=table_name
class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :username
      t.string :password_digest
    end
  end

  def down
    drop_table :users
  end
end
#When done filling in, run this mirgration using rake db:migrate
