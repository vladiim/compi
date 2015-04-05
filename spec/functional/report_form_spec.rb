require 'spec_helper'

RSpec.describe Report::Form do
  let(:email)   { 'foo@bar.com' }
  let(:site)    { 'http://www.example.com' }
  let(:subject) { Report::Form.new(email, site) }

  let(:user_stub)     { Report::Form::UserStub.new }
  let(:business_stub) { Report::Form::BusinessStub.new }

  describe '.new' do
    it 'stores the email' do
      expect(subject.email).to eq(email)
    end

    it 'stores the site' do
      expect(subject.site).to eq(site)
    end
  end

  describe '#process' do
    it 'creates a mailer background job' do
      expect(UserFactory).to receive(:new) { user_stub }
      expect(user_stub).to receive(:add_business) { business_stub }
      expect(Worker::Mailer::GetReportThanks).to receive(:perform_async).with(1, 2)
      subject.process
    end
  end

  class Report::Form::UserStub
    def add_business(args); end
    def find_or_create(args); self; end
    def id; 1; end
    def update(args); nil; end
  end

  class Report::Form::BusinessStub
    def id; 2; end
  end
end