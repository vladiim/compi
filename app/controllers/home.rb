Compi::App.controllers :home do
  get :index, map: '/' do
    partials = %w(head benefits web_data)
    render 'home/index', locals: { partials: partials }
  end
end