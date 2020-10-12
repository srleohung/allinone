# rabbitmq

## Installing on Debian and Ubuntu
- Add Repository Signing Key
```bash
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -
```
- Enable apt HTTPS Transport
```bash
sudo apt-get install apt-transport-https
```

- Add a Source List File
```bash
sudo nano /etc/apt/sources.list.d/bintray.erlang.list
```
```bash
# /etc/apt/sources.list.d/bintray.erlang.list

# Distribution
# - focal for Ubuntu 20.04
# - bionic for Ubuntu 18.04
# - xenial for Ubuntu 16.04
# - buster for Debian Buster
# - stretch for Debian Stretch

# Component (Erlang/OTP Version)
# - erlang
# - erlang-22.x

# This repository provides Erlang packages produced by the RabbitMQ team
# See below for supported distribution and component values
deb https://dl.bintray.com/rabbitmq-erlang/debian $distribution $component
```

- Install Erlang Packages
```bash
sudo apt-get update -y
# This is recommended. Metapackages such as erlang and erlang-nox must only be used
# with apt version pinning. They do not pin their dependency versions.
sudo apt-get install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
```

- Package Version and Repository Pinning
```bash
sudo nano /etc/apt/preferences.d/erlang
```
```bash
# /etc/apt/preferences.d/erlang
Package: erlang*
Pin: release o=Bintray
Pin-Priority: 1000
```
```
sudo nano /etc/apt/preferences.d/rabbitmq
```
```bash
# /etc/apt/preferences.d/rabbitmq
Package: rabbitmq-server
Pin: version 1:3.8.9
Pin-Priority: 1000
```
```bash
sudo apt-cache policy
```

- Using RabbitMQ Apt Repository on PackageCloud
```bash
# import PackageCloud signing key
wget -O - "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | sudo apt-key add -
```

- Quick Start Example
```bash
#!/bin/sh

## If sudo is not available on the system,
## uncomment the line below to install it
# apt-get install -y sudo

sudo apt-get update -y

## Install prerequisites
sudo apt-get install curl gnupg -y

## Install RabbitMQ signing key
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -

## Install apt HTTPS transport
sudo apt-get install apt-transport-https

## Add Bintray repositories that provision latest RabbitMQ and Erlang 23.x releases
sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list <<EOF
## Installs the latest Erlang 23.x release.
## Change component to "erlang-22.x" to install the latest 22.x version.
## "bionic" as distribution name should work for any later Ubuntu or Debian release.
## See the release to distribution mapping table in RabbitMQ doc guides to learn more.
deb https://dl.bintray.com/rabbitmq-erlang/debian bionic erlang
## Installs latest RabbitMQ release
deb https://dl.bintray.com/rabbitmq/debian bionic main
EOF

## Update package indices
sudo apt-get update -y

## Install rabbitmq-server and its dependencies
sudo apt-get install rabbitmq-server -y --fix-missing
```

- Add a Source List File
```
sudo nano /etc/apt/sources.list.d/bintray.rabbitmq.list
```
```bash
# /etc/apt/sources.list.d/bintray.rabbitmq.list

# Distribution
# - focal for Ubuntu 20.04
# - bionic for Ubuntu 18.04
# - xenial for Ubuntu 16.04
# - buster for Debian Buster
# - stretch for Debian Stretch
# Component (Erlang/OTP Version)

# Source repository definition example.
# See below for supported distribution and component values

# Use this line to install the latest Erlang 22.3.x package available
deb https://dl.bintray.com/rabbitmq-erlang/debian $distribution erlang-22.x

# Or use this line to install the latest Erlang 23.x package available
# deb https://dl.bintray.com/rabbitmq-erlang/debian $distribution erlang

# This repository provides RabbitMQ packages
deb https://dl.bintray.com/rabbitmq/debian $distribution main
```

- Install RabbitMQ Package
```bash
sudo apt-get update -y
sudo apt-get install -y rabbitmq-server
```

- Manual Installation with Dpkg
```bash
# sync package metadata
sudo apt-get update
# install dependencies manually
sudo apt-get -y install socat logrotate init-system-helpers adduser

# download the package
sudo apt-get -y install wget
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.9/rabbitmq-server_3.8.9-1_all.deb

# install the package with dpkg
sudo dpkg -i rabbitmq-server_3.8.9-1_all.deb

rm rabbitmq-server_3.8.9-1_all.deb
```

- Run RabbitMQ Server
```bash
sudo service rabbitmq-server start
```

## Managing the Service
```bash
# checks if the local node is running and CLI tools can successfully authenticate with it
sudo rabbitmq-diagnostics ping

# prints enabled components (applications), TCP listeners, memory usage breakdown, alarms
# and so on
sudo rabbitmq-diagnostics status

# prints effective node configuration
sudo rabbitmq-diagnostics environment

# performs a more extensive health check of the local node
sudo rabbitmq-diagnostics node_health_check
```

## Log Files and Management
```bash
journalctl --system
sudo journalctl --system | grep rabbitmq
```

## RabbitMQ Enable Web Management Plugin
```bash
# Now you can open web management plugin in the browser for that enter the following URL in browser and click enter.
# http://localhost:15672
# After opening the localhost URL in browser, it will ask you for credentials to access web management plugin.
# To access rabbitmq web management dashboard, the default Username and password of  is “guest” (Username: “guest” | Password: “guest”).
sudo rabbitmq-plugins enable rabbitmq_management
```

# The basics of creating messaging applications using RabbitMQ (Golang)
- Connection
```go
conn, err := amqp.Dial("amqp://guest:guest@localhost:5672/")
failOnError(err, "Failed to connect to RabbitMQ")
defer conn.Close()

ch, err := conn.Channel()
failOnError(err, "Failed to open a channel")
defer ch.Close()
```
## One to one
- Receive
```go
q, err := ch.QueueDeclare(
    "hello", // name
    false,   // durable
    false,   // delete when unused
    false,   // exclusive
    false,   // no-wait
    nil,     // arguments
)
failOnError(err, "Failed to declare a queue")

msgs, err := ch.Consume(
    q.Name, // queue
    "",     // consumer
    true,   // auto-ack
    false,  // exclusive
    false,  // no-local
    false,  // no-wait
    nil,    // args
)
failOnError(err, "Failed to register a consumer")

go func() {
    for d := range msgs {
        log.Printf("Received a message: %s", d.Body)
    }
}()
```
- Emit
```go
q, err := ch.QueueDeclare(
    "hello", // name
    false,   // durable
    false,   // delete when unused
    false,   // exclusive
    false,   // no-wait
    nil,     // arguments
)
failOnError(err, "Failed to declare a queue")

body := "Hello World!"
err = ch.Publish(
    "",     // exchange
    q.Name, // routing key
    false,  // mandatory
    false,  // immediate
    amqp.Publishing{
        ContentType: "text/plain",
        Body:        []byte(body),
    })
```
## One to one of them
- Receive
```go
q, err := ch.QueueDeclare(
    "task_queue", // name
    true,         // durable
    false,        // delete when unused
    false,        // exclusive
    false,        // no-wait
    nil,          // arguments
)
failOnError(err, "Failed to declare a queue")

err = ch.Qos(
    1,     // prefetch count
    0,     // prefetch size
    false, // global
)
failOnError(err, "Failed to set QoS")

msgs, err := ch.Consume(
    q.Name, // queue
    "",     // consumer
    false,  // auto-ack
    false,  // exclusive
    false,  // no-local
    false,  // no-wait
    nil,    // args
)
failOnError(err, "Failed to register a consumer")

go func() {
    for d := range msgs {
        log.Printf("Received a message: %s", d.Body)
        dot_count := bytes.Count(d.Body, []byte("."))
        t := time.Duration(dot_count)
        time.Sleep(t * time.Second)
        log.Printf("Done")
        d.Ack(false)
    }
}()
```
- Emit
```go
q, err := ch.QueueDeclare(
    "task_queue", // name
    true,         // durable
    false,        // delete when unused
    false,        // exclusive
    false,        // no-wait
    nil,          // arguments
)
failOnError(err, "Failed to declare a queue")

body := bodyFrom(os.Args)
err = ch.Publish(
    "",     // exchange
    q.Name, // routing key
    false,  // mandatory
    false,
    amqp.Publishing{
        DeliveryMode: amqp.Persistent,
        ContentType:  "text/plain",
        Body:         []byte(body),
    })
failOnError(err, "Failed to publish a message")
```
## One to many
- Receive
```go
err = ch.ExchangeDeclare(
    "logs",   // name
    "fanout", // type
    true,     // durable
    false,    // auto-deleted
    false,    // internal
    false,    // no-wait
    nil,      // arguments
)
failOnError(err, "Failed to declare an exchange")

q, err := ch.QueueDeclare(
    "",    // name
    false, // durable
    false, // delete when unused
    true,  // exclusive
    false, // no-wait
    nil,   // arguments
)
failOnError(err, "Failed to declare a queue")

err = ch.QueueBind(
    q.Name, // queue name
    "",     // routing key
    "logs", // exchange
    false,
    nil,
)
failOnError(err, "Failed to bind a queue")

msgs, err := ch.Consume(
    q.Name, // queue
    "",     // consumer
    true,   // auto-ack
    false,  // exclusive
    false,  // no-local
    false,  // no-wait
    nil,    // args
)
failOnError(err, "Failed to register a consumer")

go func() {
    for d := range msgs {
        log.Printf(" [x] %s", d.Body)
    }
}()
```
- Emit
```go
err = ch.ExchangeDeclare(
    "logs",   // name
    "fanout", // type
    true,     // durable
    false,    // auto-deleted
    false,    // internal
    false,    // no-wait
    nil,      // arguments
)
failOnError(err, "Failed to declare an exchange")

body := bodyFrom(os.Args)
err = ch.Publish(
    "logs", // exchange
    "",     // routing key
    false,  // mandatory
    false,  // immediate
    amqp.Publishing{
        ContentType: "text/plain",
        Body:        []byte(body),
    })
failOnError(err, "Failed to publish a message")
```
## One to many by key
- Receive
```go
err = ch.ExchangeDeclare(
    "logs_direct", // name
    "direct",      // type
    true,          // durable
    false,         // auto-deleted
    false,         // internal
    false,         // no-wait
    nil,           // arguments
)
failOnError(err, "Failed to declare an exchange")

q, err := ch.QueueDeclare(
    "",    // name
    false, // durable
    false, // delete when unused
    true,  // exclusive
    false, // no-wait
    nil,   // arguments
)
failOnError(err, "Failed to declare a queue")

if len(os.Args) < 2 {
    log.Printf("Usage: %s [info] [warning] [error]", os.Args[0])
    os.Exit(0)
}
for _, s := range os.Args[1:] {
    log.Printf("Binding queue %s to exchange %s with routing key %s",
        q.Name, "logs_direct", s)
    err = ch.QueueBind(
        q.Name,        // queue name
        s,             // routing key
        "logs_direct", // exchange
        false,
        nil)
    failOnError(err, "Failed to bind a queue")
}

msgs, err := ch.Consume(
    q.Name, // queue
    "",     // consumer
    true,   // auto ack
    false,  // exclusive
    false,  // no local
    false,  // no wait
    nil,    // args
)
failOnError(err, "Failed to register a consumer")

go func() {
    for d := range msgs {
        log.Printf(" [x] %s", d.Body)
    }
}()
```
- Emit
```go
err = ch.ExchangeDeclare(
    "logs_direct", // name
    "direct",      // type
    true,          // durable
    false,         // auto-deleted
    false,         // internal
    false,         // no-wait
    nil,           // arguments
)
failOnError(err, "Failed to declare an exchange")

body := bodyFrom(os.Args)
err = ch.Publish(
    "logs_direct",         // exchange
    severityFrom(os.Args), // routing key
    false,                 // mandatory
    false,                 // immediate
    amqp.Publishing{
        ContentType: "text/plain",
        Body:        []byte(body),
    })
failOnError(err, "Failed to publish a message")
```
## One to many by topic
- Receive
```go
err = ch.ExchangeDeclare(
    "logs_topic", // name
    "topic",      // type
    true,         // durable
    false,        // auto-deleted
    false,        // internal
    false,        // no-wait
    nil,          // arguments
)
failOnError(err, "Failed to declare an exchange")

q, err := ch.QueueDeclare(
    "",    // name
    false, // durable
    false, // delete when unused
    true,  // exclusive
    false, // no-wait
    nil,   // arguments
)
failOnError(err, "Failed to declare a queue")

if len(os.Args) < 2 {
    log.Printf("Usage: %s [binding_key]...", os.Args[0])
    os.Exit(0)
}
for _, s := range os.Args[1:] {
    log.Printf("Binding queue %s to exchange %s with routing key %s",
        q.Name, "logs_topic", s)
    err = ch.QueueBind(
        q.Name,       // queue name
        s,            // routing key
        "logs_topic", // exchange
        false,
        nil)
    failOnError(err, "Failed to bind a queue")
}

msgs, err := ch.Consume(
    q.Name, // queue
    "",     // consumer
    true,   // auto ack
    false,  // exclusive
    false,  // no local
    false,  // no wait
    nil,    // args
)
failOnError(err, "Failed to register a consumer")

go func() {
    for d := range msgs {
        log.Printf(" [x] %s", d.Body)
    }
}()
```
- Emit
```go
err = ch.ExchangeDeclare(
    "logs_topic", // name
    "topic",      // type
    true,         // durable
    false,        // auto-deleted
    false,        // internal
    false,        // no-wait
    nil,          // arguments
)
failOnError(err, "Failed to declare an exchange")

body := bodyFrom(os.Args)
err = ch.Publish(
    "logs_topic",          // exchange
    severityFrom(os.Args), // routing key
    false,                 // mandatory
    false,                 // immediate
    amqp.Publishing{
        ContentType: "text/plain",
        Body:        []byte(body),
    })
failOnError(err, "Failed to publish a message")
```
## One request one reply
- Receive
```go
q, err := ch.QueueDeclare(
    "rpc_queue", // name
    false,       // durable
    false,       // delete when unused
    false,       // exclusive
    false,       // no-wait
    nil,         // arguments
)
failOnError(err, "Failed to declare a queue")

err = ch.Qos(
    1,     // prefetch count
    0,     // prefetch size
    false, // global
)
failOnError(err, "Failed to set QoS")

msgs, err := ch.Consume(
    q.Name, // queue
    "",     // consumer
    false,  // auto-ack
    false,  // exclusive
    false,  // no-local
    false,  // no-wait
    nil,    // args
)
failOnError(err, "Failed to register a consumer")

go func() {
    for d := range msgs {
        n, err := strconv.Atoi(string(d.Body))
        failOnError(err, "Failed to convert body to integer")

        log.Printf(" [.] fib(%d)", n)
        response := fib(n)

        err = ch.Publish(
            "",        // exchange
            d.ReplyTo, // routing key
            false,     // mandatory
            false,     // immediate
            amqp.Publishing{
                ContentType:   "text/plain",
                CorrelationId: d.CorrelationId,
                Body:          []byte(strconv.Itoa(response)),
            })
        failOnError(err, "Failed to publish a message")

        d.Ack(false)
    }
}()
```
- Emit
```go
q, err := ch.QueueDeclare(
    "",    // name
    false, // durable
    false, // delete when unused
    true,  // exclusive
    false, // noWait
    nil,   // arguments
)
failOnError(err, "Failed to declare a queue")

msgs, err := ch.Consume(
    q.Name, // queue
    "",     // consumer
    true,   // auto-ack
    false,  // exclusive
    false,  // no-local
    false,  // no-wait
    nil,    // args
)
failOnError(err, "Failed to register a consumer")

corrId := randomString(32)

err = ch.Publish(
    "",          // exchange
    "rpc_queue", // routing key
    false,       // mandatory
    false,       // immediate
    amqp.Publishing{
        ContentType:   "text/plain",
        CorrelationId: corrId,
        ReplyTo:       q.Name,
        Body:          []byte(strconv.Itoa(n)),
    })
failOnError(err, "Failed to publish a message")

for d := range msgs {
    if corrId == d.CorrelationId {
        res, err = strconv.Atoi(string(d.Body))
        failOnError(err, "Failed to convert body to integer")
        break
    }
}
```