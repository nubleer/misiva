defmodule Misiva do
  use Application

  def start(_type, _args) do
    Misiva.Supervisor.start_link
  end

  @doc """
  Starts a connetcion to Apple Push notification server.
  Returns {:ok, pid}
  """
  def connect(opts) do
    Misiva.Supervisor.connect(opts)
  end

  @doc """
  Sends the Misiva.ApnsMesage to the device identified by the token
  """
  def send(pid, token, message) do
    Misiva.Apns.send(pid, token, message)
  end
  
  @doc """
  Closes the connection to the Apple Push notification server
  """
  def close(pid) do
    Misiva.Apns.stop(pid)
  end

end
