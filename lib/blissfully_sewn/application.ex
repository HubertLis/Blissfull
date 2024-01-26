defmodule BlissfullySewn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BlissfullySewnWeb.Telemetry,
      BlissfullySewn.Repo,
      {DNSCluster, query: Application.get_env(:blissfully_sewn, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BlissfullySewn.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BlissfullySewn.Finch},
      # Start a worker by calling: BlissfullySewn.Worker.start_link(arg)
      # {BlissfullySewn.Worker, arg},
      # Start to serve requests, typically the last entry
      BlissfullySewnWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BlissfullySewn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BlissfullySewnWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
