# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PaideiaRefinery::Application.initialize!

### attempt to send mail...
#config.action_mailer.default_url_options = { :host => 'paideiainstitute.com', :port => 80, :protocol => 'http' }
#config.action_mailer.smtp_settings = {
#  :port           => ENV['MAILGUN_SMTP_PORT'], 
#  :address        => ENV['MAILGUN_SMTP_SERVER'],
#  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
#  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
#  # TODO: get a custom domain on mailgun
#  :domain         => ENV['MAILGUN_SMTP_LOGIN'].split('@')[1],
#  :authentication => :plain,

#}
#config.action_mailer.delivery_method = :smtp
