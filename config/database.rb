DB_CONFIG = { production: ENV['DATABASE_URL'],
              development: 'postgres://localhost/compi_development',
              test: 'postgres://localhost/compi_test'}

Sequel::Model.plugin(:schema)

Sequel.connect(DB_CONFIG.fetch(Padrino.env), loggers: [logger])

Sequel.inflections do |inflect|
  inflect.irregular 'business', 'businesses'
end

# Sequel::Model.db = case Padrino.env
#   when :production then Sequel.connect(ENV['DATABASE_URL'], loggers: [logger])
#   when :development  then Sequel.connect("postgres://localhost/compi_development",  :loggers => [logger])
#   when :test        then Sequel.connect("postgres://localhost/compi_test",        :loggers => [logger])
# end
