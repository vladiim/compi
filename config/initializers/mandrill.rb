require 'mandrill'

EMAIL_API = Mandrill::API.new(ENV['MANDRILL_API_KEY'])