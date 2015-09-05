Misiva
======

Misiva is an Elixir/OTP application that sends push notifications to Apple iOS apps.

## How to use it
You create a connection passing the Push notification Certificate path and the path to the Push notification key, as well as an atom to identify the environment (:development or :production):

```elixir
{:ok, apns} = Misiva.connect {:production, "/etc/certificates/cert.pem", "/etc/certificates/key.pem"}
```

With that connection, you can send notifications using the *send* method:

```elixir
Misiva.send apns,
 "f6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6af6aa", %Misiva.ApnsMessage{alert: "Hi from Misiva"}
```

Finally, once you finish sending the messages, call the *close* method to close the connection to the Apple server:
```elixir
Misiva.close apns
```

## Certificate creation
The certificates should be in *PEM* format. You can extract them from a *.p12* certificate file:


```
openssl pkcs12 -clcerts -nokeys -out cert.pem -in cert.p12

openssl pkcs12 -nocerts -out key.pem -in key.p12
```

Remove password from pem file

```
openssl rsa -in key.pem -out key-noenc.pem
```

