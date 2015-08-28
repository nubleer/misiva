defmodule Misiva.Supervisor do
	use Supervisor

	def start_link do 
    Supervisor.start_link(__MODULE__, nil, name: :misiva_supervisor)
  end
  
	def connect(opts) do
  	Supervisor.start_child(:misiva_supervisor, [opts])
  end  

  def init(opts) do
    children = [
      worker(Misiva.Apns, [opts], restart: :transient)
    ]
    supervise(children, strategy: :simple_one_for_one)
  end

end