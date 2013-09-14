class CreateWebinarsWebinarUsersJoin < ActiveRecord::Migration
  def up
    create_table :webinar_users_webinars, :id => false do |t|
      t.integer "webinar_id"
      t.integer "webinar_user_id"
    end
    add_index :webinar_users_webinars, ["webinar_id", "webinar_user_id"]
  end

  def down
    drop_table :webinar_users_webinars
  end
end
