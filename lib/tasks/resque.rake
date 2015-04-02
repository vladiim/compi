require 'resque/tasks'

namespace :resque do
  desc "Load the Application Development for Resque"
  task :setup => :environment do
    ENV['QUEUES'] = '*'
    # ENV['VERBOSE']  = '1' # Verbose Logging
    # ENV['VVERBOSE'] = '1' # Very Verbose Logging
  end
end