class CreateWebinarUsers < ActiveRecord::Migration
  def up
    create_table :webinar_users do |t|
    
      t.string :username
      t.string :email
      t.string :name
      t.string :home_institute
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
  end
  
  def down
    drop_table :webinar_users
  end
end
