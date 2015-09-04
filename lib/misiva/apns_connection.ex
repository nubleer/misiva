defmodule Misiva.ApnsConnection do

  def connect(env, {certpath, keypath}) do
    address = to_char_list server_url(env)
    port = 2195
    cert = to_char_list certpath
    key  = to_char_list keypath
    options = [{:certfile, cert}, {:keyfile, key}, {:mode, :binary}, {:verify, :verify_none}]
    timeout = 10000
    :ssl.connect(address,port,options,timeout)
  end

  def send(socket, token, message) do
    payload = Misiva.ApnsMessage.as_json message
    message_length = byte_size payload
    tkn = Base.decode16!(token, case: :mixed)
    packet = <<0 :: size(8), 32 :: size(16), tkn :: binary, message_length :: size(16), payload :: binary >>
    case :ssl.send socket, packet do
      :ok ->
        {:ok, packet}
      {:error, reason} ->
        {:error, reason}
    end
  end

  def server_url(:production) do
    "gateway.push.apple.com"
  end

  def server_url(:development) do
    "gateway.sandbox.push.apple.com"
  end

end
