Misiva
======

Misiva is an Elixir/OTP application that sends push notifications to Apple iOS apps.

You create a connection passing the Push notification Certificate path and the path to the Push notification key, as well as an atom to identify the environment (:development or :production):

```elixir
{:ok, apns} = Misiva.connect {:production, "/etc/push/cert.pem", "/etc/push/key.pem"}
```

With that connection, you can send notifications using the *send* method:

```elixir
Misiva.Apns.send apns,
 "f6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6aa", %Misiva.ApnsMessage{alert: "Hi from Misiva"}
```


