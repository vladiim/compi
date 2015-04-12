Compi::App.controllers :reports do
  get :index, map: '/reports' do
    render 'reports/index'
  end

  post :get_report, map: '/reports' do
    subscribe = params.fetch('subscribe') { '0' }
    form = Report::Form.new(params.fetch('email'),
                            params.fetch('competitor_website'),
                            subscribe.to_i)
    if form.valid?
      form.process
      render 'reports/thanks', locals: { message: form.message }
    else
      render 'reports/index', locals: { errors: form.errors }
    end
  end
end