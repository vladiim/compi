namespace :migrate do
  desc 'Migrate dev and test up'
  task :up do
    `rake sq:migrate:up`
    `rake sq:migrate:up RACK_ENV='test'`
  end

  desc 'Migrate dev and test down'
  task :down do
    `rake sq:migrate:down`
    `rake sq:migrate:down RACK_ENV='test'`
  end
end

task migrate: ['migrate:up']