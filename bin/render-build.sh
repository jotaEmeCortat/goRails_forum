#!/usr/bin/env bash

# Exit on error
set -o errexit

# Install gems
bundle install

# Run database migrations first
bin/rails db:migrate

# Build Tailwind CSS for production
bin/rails tailwindcss:build

# Precompile assets (includes CSS and JS)
bin/rails assets:precompile

# Clean old assets (optional, but good practice)
bin/rails assets:clean
