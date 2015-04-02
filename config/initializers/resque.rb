# # padrino_env   = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"
# padrino_env   = Padrino.env
# resque_config = YAML.load_file Padrino.root('config','redis.yml')
# Resque.redis  = resque_config[padrino_env]