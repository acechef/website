HUGO_VERSION=0.70.0

# The CONTAINER_ENGINE variable is used for specifying the container engine. By default 'docker' is used
# but this can be overridden when calling make, e.g.
# CONTAINER_ENGINE=podman make container-image
CONTAINER_ENGINE ?= docker
CONTAINER_IMAGE   = grds-hugo
CONTAINER_RUN     = $(CONTAINER_ENGINE) run --rm --interactive --tty --volume $(CURDIR):/src

CCRED=\033[0;31m
CCEND=\033[0m

module-check:
	@git submodule status --recursive | awk '/^[+-]/ {printf "\033[31mWARNING\033[0m Submodule not initialized: \033[34m%s\033[0m\n",$$2}' 1>&2

all: build ## Build site with production settings and put deliverables in ./public

build: module-check ## Build site with production settings and put deliverables in ./public
	hugo --minify

container-image:
	$(CONTAINER_ENGINE) build . \
		--network=host \
		--tag $(CONTAINER_IMAGE) \
		--build-arg HUGO_VERSION=$(HUGO_VERSION)

container-build: module-check
	$(CONTAINER_RUN) $(CONTAINER_IMAGE) npm audit fix && hugo --minify

container-serve: module-check
	$(CONTAINER_RUN) --mount type=tmpfs,destination=/src/resources,tmpfs-mode=0755 -p 1313:1313 $(CONTAINER_IMAGE) hugo server --buildFuture --bind 0.0.0.0