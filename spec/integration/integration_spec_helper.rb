require 'spec_helper'
require 'capybara/rspec'

Capybara.configure { |config| config.app = app }