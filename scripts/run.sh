#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Wait for the database to be ready (if using a database)
# You may need to install 'wait-for-it' or use another method
# ./wait-for-it.sh db:5432 --timeout=30 --strict -- echo "Database is up"

# # Run any necessary setup tasks
# echo "Collecting static files..."
# flask collect  # If using Flask extensions for static files (Optional)

# # Run database migrations (if using Flask-Migrate)
# echo "Applying database migrations..."
# flask db upgrade

# Start Gunicorn to serve the Flask app
echo "Starting Gunicorn..."
gunicorn --bind :9000 --workers 4 app:app  # Update 'app:app' based on your Flask app's structure
