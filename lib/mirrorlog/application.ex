defmodule Mirrorlog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  # Compile-time env
  @mix_env System.get_env("MIX_ENV")

  def mix_env() do
    @mix_env
  end

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Mirrorlog.Repo,
      # Start the Telemetry supervisor
      MirrorlogWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mirrorlog.PubSub},
      # Start the Endpoint (http/https)
      MirrorlogWeb.Endpoint
      # Start a worker by calling: Mirrorlog.Worker.start_link(arg)
      # {Mirrorlog.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mirrorlog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MirrorlogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
