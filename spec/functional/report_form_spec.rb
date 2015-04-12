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

  describe '#valid?' do
    let(:result) { subject.valid? }

    context 'invalid email' do
      let(:subject) { Report::Form.new('bad email@lol', 'http://notsite.com') }

      it 'is invalid' do
        expect(result).to be(false)
      end
    end

    context 'invalid site' do
      let(:subject) { Report::Form.new('good.email@lol.com', 'notsite.') }

      it 'is invalid' do
        expect(result).to be(false)
      end
    end
  end

  describe '#errors', focus: true do
    let(:result) { subject.errors }
    let(:email_error) { { email: 'not an email, use format "name@email.com"' } }
    let(:site_error) { { site: 'not a URL, use format "http://sitename.com"' } }

    context 'valid email' do
      it 'is empty' do
        expect(result).to eq({})
      end
    end

    context 'invalid email' do
      let(:subject) { Report::Form.new('bad email@lol', 'http://notsite.com') }

      it 'has an invalid email message' do
        expect(result).to eq(email_error)
      end
    end

    context 'invalid site' do
      let(:subject) { Report::Form.new('goodemail@lol.com', 'notsite.com') }

      it 'has an invalid site message' do
        expect(result).to eq(site_error)
      end
    end

    context 'invalid site and email' do
      let(:subject) { Report::Form.new('bad email@lol', 'notsite.com') }

      it 'has an invalid site email message' do
        message = email_error.merge(site_error)
        expect(result).to eq(message)
      end
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