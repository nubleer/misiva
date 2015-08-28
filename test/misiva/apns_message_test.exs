defmodule Misiva.ApnsMessageTest do
	use ExUnit.Case

	test "message encoding" do
		msg = %Misiva.ApnsMessage{alert: "Hola"}
		encoded = Misiva.ApnsMessage.as_json msg
		assert "{\"apns\":{\"sound\":null,\"badge\":null,\"alert\":\"Hola\"}}" == encoded
	end

end