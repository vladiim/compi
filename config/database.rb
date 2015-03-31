# DATABASE_URL = $(heroku config:get DATABASE_URL -a compi) if Padrino.env == :development
Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure

# Sequel::Model.db = if Padrino.env == :development || :test
#     Sequel.connect("postgres://localhost/compi_#{ Padrino.env.to_s }", :loggers => [logger])
#   else
#     Sequel.connect(ENV['DATABASE_URL'])
# end

Sequel::Model.db = case Padrino.env
  when :production then Sequel.connect(ENV['DATABASE_URL'], loggers: [logger])
  when :development  then Sequel.connect("postgres://localhost/compi_development",  :loggers => [logger])
  when :test        then Sequel.connect("postgres://localhost/compi_test",        :loggers => [logger])
end
