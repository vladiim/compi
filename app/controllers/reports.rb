Compi::App.controllers :reports do
  get :index, map: '/reports' do
    render 'reports/index'
  end

  post :get_report, map: '/reports' do
    report = Report::Form.new(params['email'], params['competitor_website'])
    report.process
    render 'reports/thanks', locals: { message: report.message }
  end
end