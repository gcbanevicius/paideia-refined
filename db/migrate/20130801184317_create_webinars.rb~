class CreateWebinars < ActiveRecord::Migration
  def up
    create_table :webinars do |t|
      t.string :title
      t.string :view_url
      t.string :edit_url
      t.string :embed_url
      t.integer :status

      t.timestamps
    end
  end
  
  def down
    drop_table :webinars
  end
end
