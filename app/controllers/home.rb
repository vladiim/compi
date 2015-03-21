Compi::App.controllers :home do
  get :index, map: '/' do
    partials = %w(head why how)
    render 'home/index', locals: { partials: partials }
  end
end