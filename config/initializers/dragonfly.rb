##require 'dragonfly/rails/images'

##app = Dragonfly[:images]
##app.datastore = Dragonfly::DataStorage::S3DataStore.new({
##  :bucket_name        => 'paideiainstitute',
##  :access_key_id      => 'AKIAIQAPQZDNN3TDRBQQ',
##  :secret_access_key  => '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'
##})

require 'dragonfly'
app = Dragonfly[:images]

app.configure_with(:imagemagick)
app.configure_with(:rails)
if Rails.env.production?
  app.configure do |c|
    c.datastore = Dragonfly::DataStorage::S3DataStore.new(
      :bucket_name => 'my-bucket-name',
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    )
  end
end

app.define_macro(ActiveRecord::Base, :image_accessor)

