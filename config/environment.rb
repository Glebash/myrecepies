# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


#для imagemagic
ENV['PATH'] = "/usr/local/bin:#{ENV['PATH']}"
