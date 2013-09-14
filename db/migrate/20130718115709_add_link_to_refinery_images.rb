class AddLinkToRefineryImages < ActiveRecord::Migration
  def change
    add_column :refinery_images, :link, :string
  end
end
