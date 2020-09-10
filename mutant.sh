#/usr/bin/bash -ex

bundle exec mutant \
  --zombie         \
  -- 'Anima*'
