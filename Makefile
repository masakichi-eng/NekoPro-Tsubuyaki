build:
	docker-compose build

console:
	docker-compose run --rm web bundle exec rails console

up:
	rm -rf tmp/pids/*
	touch tmp/caching-dev.txt
	docker-compose up

stop:
	docker-compose stop

down:
	docker-compose down

install:
	docker-compose run --rm web bundle install
	docker-compose run --rm web yarn install

lint:
	docker-compose run --rm web bundle exec rubocop

rspec:
	docker-compose run --rm web bundle exec rspec

fix:
	docker-compose run --rm web bundle exec rubocop -a

migrate:
	docker-compose run --rm web bundle exec rails db:migrate

reset-db:
	docker-compose run --rm web bundle exec rails db:migrate:reset db:seed

setup:
	docker-compose run --rm web bundle exec rails db:drop db:create db:migrate db:seed

bash:
	docker-compose exec web /bin/bash

test: lint rspec

all: build install setup
