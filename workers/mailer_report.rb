module Worker
  module Mailer
    class GetReportThanks
      include Sidekiq::Worker

      def perform(user_id, business_id)
        
        EmailTemplate::GetReportThanks.new(user_id, business_id).deliver
      end
    end
  end
end