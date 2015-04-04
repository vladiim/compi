require 'dotenv'

file = "#{ Dir.pwd }/.#{ Padrino.env }.env"
Dotenv.load(file) unless Padrino.env == :production