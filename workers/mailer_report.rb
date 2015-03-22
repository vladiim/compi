module Worker
  module Mailer
    class GetReportThanks
      include Sidekiq::Worker
    end
  end
end