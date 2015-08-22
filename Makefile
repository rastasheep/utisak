.PHONY: build

SHA := $(shell git rev-parse --short HEAD)
VERSION := $(shell cat VERSION)
ITTERATION := $(shell date +%s)

all: build

build:
	mkdir -p packaging/output
	bundle exec middleman build
	cp -r build packaging/root/usr/local/share/utisak-webui

run:
	bundle exec middleman server

clean:
	rm -rf build/*
	rm -rf packaging/output
	rm -f packaging/root/usr/local/bin/utisak-webui || true

packages: clean build deb rpm

deb:
	$(call build_dep,utisak-webui)

rpm:
	$(call build_rpm,utisak-webui)

define build_dep
	fpm -s dir -t deb \
		--name $1 \
		--version $(VERSION) \
		--package packaging/output/$1.deb \
		--deb-priority optional \
		--category admin \
		--force \
		--iteration $(ITTERATION) \
		--deb-compression bzip2 \
		--url https://github.com/rastasheep/utisak-webui \
		--description "Discover news, easily" \
		--maintainer "Aleksandar Diklic <rastasheep@gmail.com>" \
		--license "MIT" \
		packaging/root/=/
	cp packaging/output/$1.deb packaging/output/$1.deb.$(SHA)
endef

define build_rpm
	fpm -s dir -t rpm \
		--name $1 \
		--version $(VERSION) \
		--package packaging/output/$1.rpm \
		--rpm-compression bzip2 \
		--rpm-os linux \
		--force \
		--iteration $(ITTERATION) \
		--url https://github.com/rastasheep/utisak-webui \
		--description "Discover news, easily" \
		--maintainer "Aleksandar Diklic <rastasheep@gmail.com>" \
		--license "MIT" \
		packaging/root/=/
	cp packaging/output/$1.rpm packaging/output/$1.rpm.$(SHA)
endef
