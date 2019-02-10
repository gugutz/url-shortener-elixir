defmodule URL.Application do
  use Application

  alias URL.{Server, }

  def start(_type, _args) do
    # port = Application.fetch_env!(:url, :routing_table) || raise "missing $PORT application variable"

    children = [
      {URL.Socket, name: URL.Socket},
      {URL.Server, name: URL.Server},
      {URL.Bucket, name: URL.Bucket},
      {URL.Counter, name: URL.Counter},
      {Task.Supervisor, name: URL.TaskSupervisor},
      {Repo, []},
      Supervisor.child_spec({Task, fn -> Socket.accept(port) end}, restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: URL.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
