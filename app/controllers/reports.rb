Compi::App.controllers :reports do
  get :index, map: '/reports' do
    render 'reports/index'
  end

  post :get_report, map: '/reports' do
    site    = params['competitor_website']
    email   = params['email']
    report  = Report::Form.new(email, site)
    report.generate_report
    render 'reports/thanks', locals: { message: report.message }
  end
end