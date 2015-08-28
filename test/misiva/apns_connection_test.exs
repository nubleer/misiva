defmodule Misiva.ApnsConnectionTest do
	use ExUnit.Case

  test "production gateway url" do
    assert Misiva.ApnsConnection.server_url(:production) == "gateway.push.apple.com"
  end

  test "development gateway url" do
    assert Misiva.ApnsConnection.server_url(:development) == "gateway.sandbox.push.apple.com"
  end
  
end