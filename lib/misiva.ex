defmodule Misiva do
	use Application

	def start(_type, _args) do		
    Misiva.Supervisor.start_link
  end

  def connect(opts) do
  	Misiva.Supervisor.connect(opts)
	end

	def send(pid, token, message) do
		Misiva.Apns.send(pid, token, message)
	end


end
