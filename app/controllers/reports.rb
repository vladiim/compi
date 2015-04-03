Compi::App.controllers :reports do
  get :index, map: '/reports' do
    render 'reports/index'
  end

  post :get_report, map: '/reports' do
    form = Report::Form.new(params.fetch('email'),
                            params.fetch('competitor_website'),
                            params.fetch('subscribe').to_i)
    form.process
    render 'reports/thanks', locals: { message: form.message }
  end
end