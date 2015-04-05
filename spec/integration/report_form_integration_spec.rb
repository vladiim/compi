require_relative 'integration_spec_helper'

RSpec.describe 'Reports', type: :feature do
  let(:email) { 'foo@bar.com' }
  let(:site)  { 'http://www.example.com' }

  describe 'fill in get report form' do
    context 'fields entered' do
      it 'loads the thank you page' do
        fill_in_report_form
        expect(page).to have_content(Copy::Report.thank_you_page(email, site))
      end

      it 'generates a user, mailer and report' do
        expect(Report::Form).to receive(:new).with(email, site, 1) { ReportFormStub }
        expect(ReportFormStub).to receive(:process)
        fill_in_report_form
      end
    end

    context 'fields not entered' do
      it 'loads the errors' do
        
      end
    end
  end

  def fill_in_report_form
    visit '/'
    within 'nav' do
      click_link 'Get report'
    end
    fill_in 'competitor_website', with: site
    fill_in 'email', with: email
    check 'subscribe'
    click_button 'Get report'
  end
end

module ReportFormStub
  def self.process; end

  def self.message; end
end