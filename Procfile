web: bundle exec thin start -p $PORT
worker: bundle exec sidekiq -r ./config/boot.rb -c 2 -e production