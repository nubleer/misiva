defmodule Misiva.Apns do
  use GenServer
  require Logger

  defmodule State do
     defstruct socket: nil, certpath: nil, keypath: nil, callback_pid: nil
  end

  @doc """
  Starts the Apns server.
  """
  def start_link(state, opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @doc """
  Sends the given ApnsMessage to the device identified by the token
  """
  def send(pid, token, message) do
    :gen_server.cast(pid, {:send, token, message})
  end

  @doc """
  Stops the Apns server and closes the SSL connections to Apple servers
  """
  def stop(pid) do
    :gen_server.call(pid, :close_ssl)
  end

  ## Server Callbacks  
  def init({env, certpath, keypath}) do
    case Misiva.ApnsConnection.connect(env, {certpath, keypath}) do
      {:ok, socket} ->
        {:ok, %State{socket: socket, certpath: certpath, keypath: keypath}}
      {:error, reason} ->
        {:error, reason}
    end
  end

  def init({env, certpath, keypath, callback_pid}) do
    case Misiva.ApnsConnection.connect(env, {certpath, keypath}) do
      {:ok, socket} ->
        {:ok, %State{socket: socket, certpath: certpath, keypath: keypath, callback_pid: callback_pid}}
      {:error, reason} ->
        {:error, reason}
    end
  end
 
  def handle_cast({:send, token, message}, state) do
    Misiva.ApnsConnection.send(state.socket, token, message)
#send state.callback_pid, r
    {:noreply, state}
  end

  def handle_call(:close_ssl, _, state) do
    Misiva.ApnsConnection.close(state.socket)
    {:stop, :normal, :shutdown_ok, state}
  end
end
