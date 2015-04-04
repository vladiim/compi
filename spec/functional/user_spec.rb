require 'spec_helper'

RSpec.describe User do
  let(:subject) { User.new }
  let(:email)   { 'foo@bar.com' }

  describe '#name' do
    let(:result) { subject.name }

    context 'no email' do
      it 'returns nil' do
        expect(result).to eq(nil)
      end
    end

    context 'with email' do
      before { subject.email = email }

      context 'without name' do
        it 'returns the beginning of their email' do
          expect(result).to eq('Foo')
        end
      end
    end
  end

  describe 'validations' do
    before do
      subject.email      = email
      subject.created_at = Time.now
    end

    context 'no values' do
      it 'is valid' do
        expect(subject.valid?).to be
      end
    end

    describe 'email' do
      context 'valid email' do
        it 'is valid' do
          subject.email = email
          expect(subject.valid?).to be
        end
      end

      context 'invalid email' do
        it 'is not valid' do
          subject.email = 'email'
          expect(subject.valid?).not_to be
        end
      end
    end
  end
end