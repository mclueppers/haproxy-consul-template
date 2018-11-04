build:
	@sudo docker-compose build --no-cache

init:
	@sudo docker-compose up -d \
				--renew-anon-volumes \
				--remove-orphans \
				--scale hello-world-prod-blue-a=3 \
				--scale hello-world-prod-blue-b=2 \
				--scale hello-world-prod-green-b=2 \
				--scale haproxy-production-blue=2
	@sudo docker-compose exec consul consul kv import "`cat consul_seed.json`"
	@sudo docker-compose port haproxy-production-blue 80
