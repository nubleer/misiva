defmodule Misiva.Apns do
	use GenServer

	defmodule State do
     defstruct socket: nil, certpath: nil, keypath: nil, callback_pid: nil
  end

	@doc """
  Starts the Apns server.
  """
  def start_link(state, opts) do		
    GenServer.start_link(__MODULE__, opts)
  end
  

  ## Server Callbacks  
  def init({certpath, keypath}) do
  	case Misiva.ApnsConnection.connect(:production, {certpath, keypath}) do 
  		{:ok, socket} ->  					  		
  			{:ok, %State{socket: socket, certpath: certpath, keypath: keypath}}
  		{:error, reason} ->
  			{:error, reason}
  	end   
  end

  def init({certpath, keypath, callback_pid}) do
  	case Misiva.ApnsConnection.connect(:production, {certpath, keypath}) do 
  		{:ok, socket} ->  					  		
  			{:ok, %State{socket: socket, certpath: certpath, keypath: keypath, callback_pid: callback_pid}}
  		{:error, reason} ->
  			{:error, reason}
  	end   
  end

  def send(pid, token, message) do   	
  	:gen_server.cast(pid, {:send, token, message})  	
  end
 
  def handle_cast({:send, token, message}, state) do  	
  	Misiva.ApnsConnection.send(state.socket, token, message)
    { :noreply, state }
  end

end