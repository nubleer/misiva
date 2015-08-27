defmodule Misiva.ApnsTest do
	use ExUnit.Case, async: true

	setup do
    {:ok, state} = Misiva.Apns.start_link([])    
  end

  # test "sends message",  %{state: state}  do
  #   assert Misiva.Apns.send(state) != :error
  # end

end