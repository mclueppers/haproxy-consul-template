build:
	@sudo docker-compose build --no-cache

init:
	@sudo docker-compose up -d --renew-anon-volumes --remove-orphans \
				--scale hello-world-prod-blue=2 \
				--scale hello-world-prod-green=2 \
				--scale haproxy-production-blue=2
	@sudo docker-compose exec consul consul kv import "`cat consul_seed.json`"
