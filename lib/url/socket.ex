defmodule URL.Socket do

  alias URL.{Server}

  require Logger

  def accept (port) do
    port = 4040
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: :false, reuseaddr: true])
    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(URL.TaskSupervisor, Server, :serve, [client])
    :ok = :gen_tcp.controlling_process(client, pid)

    loop_acceptor(socket)
  end
  

end
