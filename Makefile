# Define variables for commands
AUTOPEP8 = autopep8 .
FLAKE8 = flake8 .


# The default target when you run `make`
run:
	@echo "Running autopep8..."
	cd app && $(AUTOPEP8) --in-place --recursive
	@echo "Running flake8..."
	cd app && $(FLAKE8)

# Add a clean target if you want to remove unwanted files (optional)
clean:
	@echo "Cleaning up..."
	rm -rf app/__pycache__


test:
	cd app && pytest

setup-init:
	cd infra && aws-vault exec craigryy -- sudo -E  docker compose run --rm terraform -chdir=setup init

setup-all:
	cd infra && aws-vault exec craigryy -- sudo -E  docker compose run --rm terraform -chdir=setup fmt
	cd infra && aws-vault exec craigryy -- sudo -E  docker compose run --rm terraform -chdir=setup validate
	cd infra && aws-vault exec craigryy -- sudo -E  docker compose run --rm terraform -chdir=setup apply
