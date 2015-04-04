require 'spec_helper'

RSpec.describe Email do
  let(:subject) { Email.new(MockTemplate) }

  describe '#initialize' do
    it 'sets variables' do
      expect(subject.from_email).to be_a(String)
      expect(subject.from_name).to be_a(String)
      expect(subject.api).to be_a(Mandrill::API)
      expect(subject.template).to eq(MockTemplate)
    end
  end

  describe '#message' do
    let(:result) { subject.message }

    it "completes the details with it's template" do
      expect(result['subject']).to        eq('SUBJECT')
      expect(result['to'][0]['name']).to  eq('NAME')
      expect(result['to'][0]['email']).to eq('EMAIL')
      expect(result['html']).to           eq('HTML CONTENT')
      expect(result['text']).to           eq('TEXT CONTENT')
      expect(result['recipient_metadata'][0]['values']['user_id']).to eq('ID')
    end
  end

  describe '#deliver' do
    let(:result) { subject.deliver }

    it 'passes the message to the email api' do
      expect(subject.api).to receive(:messages) { MockApiMessages.new }
      expect(result).to eq('SEND BY API')
    end

    context 'api returns error' do
      it 'logs the error' do
        expect(subject.api).to receive(:messages).and_raise(MockError)
        expect(result).to eq("An email send error occurred: ERROR MESSAGE\n The email message: #{subject.message}")
      end
    end
  end

  class MockApiMessages
    def send(message)
      'SEND BY API'
    end
  end

  class MockError < StandardError
    def message
      'ERROR MESSAGE'
    end
  end

  MockUser = OpenStruct.new(
    id:    'ID',
    name:  'NAME',
    email: 'EMAIL',
  )
  MockTemplate = OpenStruct.new(
    subject_line: 'SUBJECT',
    html_content: 'HTML CONTENT',
    text_content: 'TEXT CONTENT',
    user: MockUser
  )
end