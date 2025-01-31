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
