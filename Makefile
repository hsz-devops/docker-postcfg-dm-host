# v2.1.1    2016-06-28     joaocc-dev@live.com

TAG_VERSION=160628b

# these 2 vars must match the content of docker-compose.yml
DH_ID=highskillz/docker-postcfg-dm-host
DC_SVC=postcfg-docker-host

THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

default:

run: build postcfg-dm

# --------------------------------------------------------------------------
postcfg-dm:
	cd "$(THIS_DIR)src.ubuntu" ;\
	TAG_VERSION=${TAG_VERSION} \
		docker-compose run --rm ${DC_SVC}

# --------------------------------------------------------------------------
rebuild:
	cd "$(THIS_DIR)src.ubuntu" ;\
	TAG_VERSION=${TAG_VERSION} \
		docker-compose build --no-cache ${DC_SVC}

build:
	cd "$(THIS_DIR)src.ubuntu" ;\
	TAG_VERSION=${TAG_VERSION} \
		docker-compose build ${DC_SVC}

# --------------------------------------------------------------------------
d-pull:
	docker pull ${DH_ID}

d-push:
	docker push ${DH_ID}
	docker push ${DH_ID}:${TAG_VERSION}

# --------------------------------------------------------------------------
clean-junk:
	docker rm  `docker ps -aq -f status=exited`      || true
	docker rmi `docker images -q -f dangling=true`   || true
	docker volume rm `docker volume ls -qf dangling=true`   || true

clean-images:
	docker rmi ${DH_ID}        || true

d-rmi: clean-images clean-junk

# --------------------------------------------------------------------------
list:
	docker images
	docker volume ls
	docker ps -a

# --------------------------------------------------------------------------
shell:
	cd "$(THIS_DIR)src.ubuntu" ;\
	docker-compose run --rm --entrypoint bash ${DC_SVC}

