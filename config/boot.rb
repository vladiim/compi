# Constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

# Hooks
Padrino.before_load do
  Padrino.require_dependencies "#{ Padrino.root }/config/initializers/*.rb"
  require File.expand_path('../workers.rb', __FILE__)
end

Padrino.after_load do
  Sidekiq.logger = Padrino.logger
  Padrino.require_dependencies("#{ Padrino.root }/app/mailers/*.rb")
end

Padrino.load!
