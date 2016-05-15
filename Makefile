# v1.2.3    2016-05-09     webmaster@highskillz.com

TAG_VERSION=160515a

DH_ID=highskillz/postcfg-ubuntu-docker-machine-host
DC_SVC=postcfg-docker-host

TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

default:

run: build postcfg-dm

# --------------------------------------------------------------------------
postcfg-dm:
	pushd src.ubuntu ;\
	docker-compose run --rm $(DC_SVC)

# --------------------------------------------------------------------------
rebuild:
	pushd src.ubuntu ;\
	docker-compose build --no-cache $(DC_SVC)

build:
	pushd src.ubuntu ;\
	docker-compose build $(DC_SVC)

# --------------------------------------------------------------------------
d-pull:
	docker pull $(DH_ID)

d-push:
	docker push $(DH_ID)

# --------------------------------------------------------------------------
clean-junk:
	docker rm  `docker ps -aq -f status=exited`      || true
	docker rmi `docker images -q -f dangling=true`   || true
	docker volume rm `docker volume ls -qf dangling=true`   || true

clean-images:
	docker rmi $(DH_ID)        || true

d-rmi: clean-images clean-junk

# --------------------------------------------------------------------------
list:
	docker images
	docker volume ls
	docker ps -a

# --------------------------------------------------------------------------
shell:
	pushd src.ubuntu ;\
	docker-compose run --rm --entrypoint bash $(DC_SVC)

