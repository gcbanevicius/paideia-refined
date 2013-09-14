class CreateContacts < ActiveRecord::Migration

  def self.up
    create_table :refinery_contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :message

      t.timestamps
    end

    add_index :refinery_contacts, :id

    if (seed = Rails.root.join('db', 'seeds', 'contacts.rb')).exist?
      load(seed)
    end
  end

  def self.down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "contacts"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/contacts"})
    end

    drop_table :refinery_contacts
  end

end
