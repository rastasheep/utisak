.PHONY: deps build run clean release

all: build

deps:
	bundle install --quiet --jobs 4 --path --path vendor/bundle --clean

build: deps
	bundle exec middleman build

run: deps
	bundle exec middleman server

clean:
	rm -rf build/*

release: build
	bundle exec middleman s3_sync
