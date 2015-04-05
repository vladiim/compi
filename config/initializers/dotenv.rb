unless Padrino.env == :production
  require 'dotenv'
  file = "#{ Dir.pwd }/.#{ Padrino.env }.env"
  Dotenv.load(file)
end