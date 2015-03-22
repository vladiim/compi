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
      expect(User).to receive(:new).with(email) { UserStub }
      expect(Worker::Mailer::GetReportThanks).to receive(:perform_async).with(email, site)
      expect(Worker::Report::Generator).to receive(:perform_async).with(email, site)
      subject.process
    end
  end

  module UserStub
    def self.save; end
  end
end