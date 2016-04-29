DH_ID=highskillz/postcfg-ubu1404-docker-machine
DC_SVC=postcfg-docker-host

TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

BUILD_CACHE=--no-cache
# --force-rm

default:

run: build postcfg-dm

# --------------------------------------------------------------------------
postcfg-dm:
	docker-compose run --rm $(DC_SVC)

# --------------------------------------------------------------------------
build:
	docker-compose build $(BUILD_CACHE) $(DC_SVC)

# --------------------------------------------------------------------------
d-pull:
	docker pull $(DH_ID)

d-push:
	docker push $(DH_ID)

# --------------------------------------------------------------------------
d-rmi: clean-images clean-junk

clean-junk:
	docker rm  `docker ps -aq -f status=exited`      || true
	docker rmi `docker images -q -f dangling=true`   || true
	docker volume rm `docker volume ls -qf dangling=true`   || true

clean-images:
	docker rmi $(DH_ID)        || true

# --------------------------------------------------------------------------
list:
	docker images
	docker volume ls
	docker ps -a

# --------------------------------------------------------------------------
shell:
	docker-compose run --rm --entrypoint bash $(DC_SVC)
