# DATABASE_URL = $(heroku config:get DATABASE_URL -a compi) if Padrino.env == :development
Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
  when :development then Sequel.connect(ENV['DATABASE_URL'])
  when :production  then Sequel.connect("postgres://localhost/compi_production",  :loggers => [logger])
  when :test        then Sequel.connect("postgres://localhost/compi_test",        :loggers => [logger])
end
