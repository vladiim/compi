require 'spec_helper'

RSpec.describe UserFactory do
  let(:email)     { 'foo@email.com' }
  let(:mock_user) { UserFactory::MockUser.new }

  describe '.find_or_create' do
    context 'with email' do
      let(:result) { subject.find_or_create(args) }
      let(:args)   { { email: email } }
      let(:email_expectation) { expect(User).to receive(:find_or_create).with(email: email) { mock_user } }

      it 'passes the message to the user' do
        email_expectation
        result
      end

      context 'and other args' do
        let(:args)   { { email: email, other: 'other' } }

        it 'finds the user with the email' do
          email_expectation
          result
        end

        context 'with add subscription' do
          let(:args) { { email: email, subscription: 1 } }

          it 'updates the user' do
            email_expectation
            expect(mock_user).to receive(:update).with(subscription: 1)
            result
          end
        end

        context 'with remove subscription' do
          let(:args) { { email: email, subscription: 0 } }

          it "doesn't update the user" do
            email_expectation
            expect(mock_user).not_to receive(:update)
            result
          end
        end
      end
    end

    context 'without email' do
      let(:result) { subject.find_or_create(blah: 'lol') }

      it 'throws an error' do
        expect{ result }.to raise_error(UserFactory::NoEmailError)
      end
    end
  end

  class UserFactory::MockUser
    def update(args)
      
    end
  end
end