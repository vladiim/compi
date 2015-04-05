require 'spec_helper'

RSpec.describe EmailTemplate::GetReportThanks do
  let(:user_id)     { '1' }
  let(:business_id) { '2' }
  let(:user)        { MockUser }
  let(:business)    { MockBusiness }
  let(:subject)     { EmailTemplate::GetReportThanks.new(user_id, business_id) }

  before do
    expect(User).to receive(:find).with(id: user_id.to_i) { user }
    expect(Business).to receive(:find).with(id: business_id.to_i) { business }
  end

  describe '#initialize' do
    it "sets it's variables" do
      expect(subject.user).to eq(user)
      expect(subject.business).to eq(business)
      expect(subject.mailer.template).to eq(subject)
      expect(subject.subject_line).to be_a(String)
    end
  end

  describe 'content' do
    before { expect(subject).to receive(:content) { '# CONTENT' } }

    describe '#html_content' do
      it 'renders the content in html' do
        expect(subject.html_content.strip!).to eq('<h1>CONTENT</h1>')
      end
    end

    describe '#text_content' do
      it 'renders the content' do
        expect(subject.text_content).to eq('# CONTENT')
      end
    end
  end

  # describe '.deliver' do
  #   let(:result) { subject.deliver(user_id, busness_id) }

  #   it 'finds the user and business' do
  #     expect(User).to receive(:find).with(user_id.to_i)
  #     expect(Business).to receive(:find).with(busness_id.to_i)
  #     result
  #   end
  # end

  MockUser     = OpenStruct.new
  MockBusiness = OpenStruct.new
end