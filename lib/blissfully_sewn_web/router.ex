defmodule BlissfullySewnWeb.Router do
  use BlissfullySewnWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BlissfullySewnWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlissfullySewnWeb do
    pipe_through :browser
    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit

    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/show/edit", ProductLive.Show, :edit
    live "/colors", ColorLive.Index, :index
    live "/colors/new", ColorLive.Index, :new
    live "/colors/:id/edit", ColorLive.Index, :edit

    live "/colors/:id", ColorLive.Show, :show
    live "/colors/:id/show/edit", ColorLive.Show, :edit

    live "/size", SizeLive.Index, :index
    live "/size/new", SizeLive.Index, :new
    live "/size/:id/edit", SizeLive.Index, :edit

    live "/size/:id", SizeLive.Show, :show
    live "/size/:id/show/edit", SizeLive.Show, :edit
    get "/", PageController, :home

    live "/categories", CategoryLive.Index, :index
    live "/categories/new", CategoryLive.Index, :new
    live "/categories/:id/edit", CategoryLive.Index, :edit

    live "/categories/:id", CategoryLive.Show, :show
    live "/categories/:id/show/edit", CategoryLive.Show, :edit
    live "/vats", TariffLive.Index, :index
    live "/vats/new", TariffLive.Index, :new
    live "/vats/:id/edit", TariffLive.Index, :edit

    live "/vats/:id", TariffLive.Show, :show
    live "/vats/:id/show/edit", TariffLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlissfullySewnWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:blissfully_sewn, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BlissfullySewnWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
