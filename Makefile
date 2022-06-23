install-deps:  ## install python requirements into your virtual env
	pip install -U pip pip-tools
	pip-sync requirements.txt requirements-dev.txt
	pip install -e .
	pip install pre-commit
	pre-commit install

update-deps:  ## update requirements: produces requirements.txt and requirements-dev.txt
	pip-compile --output-file requirements.txt --upgrade
	pip-compile requirements-dev.in --output-file requirements-dev.txt --upgrade
	make install-deps

build:
	docker-compose build $(IMAGE)

run:
	docker-compose run workflow $(ENTRYPOINT) $(DIRECTORY)

run-tests:
	docker-compose run workflow-tests $(DIRECTORY)

down:  ## Bring all containers down
	docker-compose kill -s9
	docker-compose down --remove-orphans

clean: down  ## Delete images
	docker-compose down -v --rmi all --remove-orphans
	docker-compose rm -vf
	docker network prune -f
	docker ps
