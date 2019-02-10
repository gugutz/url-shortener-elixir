defmodule URL.Server do

  alias URL.{Socket}

  require Logger

  def serve(socket) do
    Logger.info("Starting connection with PID #{inspect(self())}")

    socket
    |> read_line()
    |> write_line(socket)
  end
  
  def read_line(socket) do
    :gen_tcp.recv(socket, 0)
  end

  def write_line(socket, {:ok, text}) do
    :gen_tcp.send(socket, text)
    end
      

end
