Compi::App.controllers :home do
  get :index, map: '/' do
    partials = %w(head body_1 body_2 body_3)
    render 'home/index', locals: { partials: partials }
  end
end