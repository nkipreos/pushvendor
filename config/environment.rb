# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
PushvendorPos::Application.initialize!

  ActionMailer::Base.smtp_settings = {
    :address => 'smtp.mandrillapp.com',
    :authentication => :plain,
    :domain => 'localhost',
    :enable_starttls_auto => true,
    :password => ENV['MANDRILL_PASS'],
    :port => '587',
    :user_name => ENV['MADRILL_USER']
  }

