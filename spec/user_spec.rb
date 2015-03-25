require 'spec_helper'

RSpec.describe User do
  let(:email)   { 'foo@bar.com' }
  let(:subject) { User.new(email) }

  # before { allow(Sequel::Model).to receive(:db) { FakeTable.new } }

  describe '.initialize' do
    it 'saves the email' do
      expect(subject.email).to eq(email)
    end
  end

  describe '#save' do
    it 'saves the user' do
      expect(subject.save).to eq('SAVED TO DB')
    end
  end

  # class FakeTable
  #   def [](args)
  #     self
  #   end

  #   def create(*args)
  #     'SAVED TO DB'
  #   end
  # end
end