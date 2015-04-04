Sequel::Model.plugin(:schema)

Sequel.connect(ENV['DATABASE_URL'], loggers: [logger])

Sequel.inflections do |inflect|
  inflect.irregular 'business', 'businesses'
end