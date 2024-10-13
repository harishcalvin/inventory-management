     #!/usr/bin/env bash
     set -o errexit
     bundle install
     bundle exec rails assets:precompile
     bundle exec rails assets:clean
     # Uncomment the following line if using a Free instance:
     # bundle exec rails db:migrate