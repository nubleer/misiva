defmodule Misiva.ApnsMessage do
  @derive [Poison.Encoder]
  
  defstruct [:sound, :badge, :alert]

  def as_json(message) do
    msg = %{:aps => message}
    Poison.encode! msg
  end

end
