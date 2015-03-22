require 'spec_helper'

RSpec.describe User do
  let(:email)   { 'foo@bar.com' }
  let(:subject) { User.new(email) }

  describe '.initialize' do
    it 'saves the email' do
      expect(subject.email).to eq(email)
    end
  end

  describe '#save' do
    it 'saves the user' do
      
    end
  end
end