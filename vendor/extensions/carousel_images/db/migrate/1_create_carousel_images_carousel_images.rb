class CreateCarouselImagesCarouselImages < ActiveRecord::Migration

  def up
    create_table :refinery_carousel_images do |t|
      t.string :title
      t.integer :image_id
      t.text :caption
      t.string :link
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-carousel_images"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/carousel_images/carousel_images"})
    end

    drop_table :refinery_carousel_images

  end

end
