#!/usr/bin/env bash
set -o errexit

echo "Starting build process..."

echo "Installing dependencies..."
bundle install

echo "Precompiling assets..."
RAILS_ENV=production bundle exec rails assets:precompile
RAILS_ENV=production bundle exec rails assets:clean

echo "Setting up database..."
RAILS_ENV=production bundle exec rails db:create || true
RAILS_ENV=production bundle exec rails db:migrate:status
RAILS_ENV=production bundle exec rails db:migrate
RAILS_ENV=production bundle exec rails db:schema:load
RAILS_ENV=production bundle exec rails db:seed

echo "Diagnosing database..."
RAILS_ENV=production bundle exec rails db:diagnose

echo "Build process completed."