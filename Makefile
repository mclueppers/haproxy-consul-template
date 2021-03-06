build:
	docker-compose build --no-cache

init:
	@docker-compose up -d --remove-orphans --scale hello-world-prod-blue-a=3 --scale hello-world-prod-blue-b=2 --scale hello-world-prod-green-b=2 --scale haproxy-production-blue=2
	@make kv-import
	@make port

kv-import:
	@docker-compose exec consul consul kv import "`cat consul_seed.json`"

kv-export:
	@docker-compose exec consul consul kv export > consul_seed.json

port:
	@docker-compose port --protocol=tcp --index=1 haproxy-production 80
	@docker-compose port --protocol=tcp --index=1 haproxy-production-blue 80

ping-a:
	@curl -iv http://`docker-compose port --protocol=tcp --index=1 haproxy-production-blue 80`

ping-b:
	@curl -iv http://`docker-compose port --protocol=tcp --index=1 haproxy-production-blue 8080`

stress-test-aa:
	@ab -n 500000 -c 300 -v 1 -C SRVID=aa -i http://`docker-compose port --protocol=tcp --index=1 haproxy-production-blue 80`/

stress-test:
	@ab -n 500000 -c 100 -v 1 -ir http://`docker-compose port --protocol=tcp --index=1 haproxy-production 80`/

stress-test-inactive:
	@ab -n 500000 -c 100 -v 1 -ir http://`docker-compose port --protocol=tcp --index=1 haproxy-production 8080`/
