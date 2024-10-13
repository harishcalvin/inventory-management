#!/usr/bin/env bash
set -o errexit

echo "Installing dependencies..."
bundle install

echo "Precompiling assets..."
bundle exec rails assets:precompile
bundle exec rails assets:clean

echo "Setting up database..."
bundle exec rails db:create RAILS_ENV=production || true
bundle exec rails db:migrate:status RAILS_ENV=production
bundle exec rails db:migrate RAILS_ENV=production
bundle exec rails db:schema:load RAILS_ENV=production
bundle exec rails db:seed RAILS_ENV=production
bundle exec rails db:diagnose RAILS_ENV=production

echo "Diagnosing database..."
echo "Database setup complete."