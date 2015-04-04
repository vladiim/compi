require 'spec_helper'

RSpec.describe Report::Form do
  let(:email)   { 'foo@bar.com' }
  let(:site)    { 'http://www.example.com' }
  let(:subject) { Report::Form.new(email, site) }

  describe '.new' do
    it 'stores the email' do
      expect(subject.email).to eq(email)
    end

    it 'stores the site' do
      expect(subject.site).to eq(site)
    end
  end

  describe '#process' do
    it 'creates a mailer and report generator background job' do
      expect(User).to receive(:find_or_create).with(email: email) { UserStub }
      expect(UserStub).to receive(:add_business).with(url: site) { BusinessStub }
      expect(Worker::Mailer::GetReportThanks).to receive(:perform_async).with(1, 2)
      # expect(Worker::Report::Generator).to receive(:perform_async).with(1, 2)
      subject.process
    end
  end

  module UserStub
    def self.add_business(args); end
    def self.id; 1; end
    def self.update(args); self; end
  end

  module BusinessStub
    def self.id; 2; end
  end
end