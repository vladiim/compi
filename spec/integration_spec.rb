require 'integration_spec_helper'

RSpec.describe 'Reports', type: :feature do
  let(:email) { 'foo@bar.com' }
  let(:site)   { 'http://www.example.com' }

  describe 'fill in get report form' do
    it 'loads the thank you page' do
      fill_in_report_form
      expect(page).to have_content(Copy::Report.thank_you_page(email, site))
    end

    it 'generates a report' do
      expect(Report::Form).to receive(:new).with(email, site) { ReportFormStub }
      expect(ReportFormStub).to receive(:generate_report)
      fill_in_report_form
    end
  end

  def fill_in_report_form
    visit '/'
    click_link 'Get report'
    fill_in 'competitor_website', with: site
    fill_in 'email', with: email
    click_button 'Get report'
  end
end

module ReportFormStub
  def self.generate_report
    'GENERATED REPORT'
  end

  def self.message; end
end