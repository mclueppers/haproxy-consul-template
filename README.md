# haproxy-consul-template

A blue/green load-balancer with A/B capabilities for each slice

# How it works?

## Moving parts

* Alpine 3.8
* HAproxy 1.8.5
* consul-template 0.19.5

## Architecture

The container runs HAproxy and consul-template as services via runit and accepts
few environment variables:

| Name | Default value | Description |
|------|---------------|:-----------:|
| CONSUL_ADDR |   | The location of the Consul server (IP:port) |
| SERVICE_NAME | haproxy | The name of the service |
| SERVICE_ENV | production | The environment this load-balancer belongs to |
| SERVICE_PATH | /service/SERVICE_NAME/SERVICE_ENV | The path to the configuration of the load-balancer inside Consul |
| BK_SERVICE_NAME | hello-world | The name of the backend service as found in Consul that this load-balancer exposes |
| BK_SERVICE_ENV | production | Environment where BK_SERVICE_NAME runs |
| BK_SERVICE_CHECK | / | HAproxy will send regular HEAD requests to this destination |

The solution allows horizontal scaling thanks to dynamic peers configuration inside HAproxy. It is nevertheless recommended to run at least 2 instances for resiliency. Hence SERVICE_NAME and SERVICE_ENV are important for discovering other peers.

## Requirements

* Consul server
* Registrator (optional)
* docker-compose for running the provided example (optional)

## Example

Look at the provided docker-compose.yml for an example that covers the full potential of the load-balancer.
