[![Build Status](https://travis-ci.org/firechicago/turf-cutter.svg?branch=master)](https://travis-ci.org/firechicago/turf-cutter) [![Code Climate](https://codeclimate.com/github/firechicago/turf-cutter.png)](https://codeclimate.com/github/firechicago/turf-cutter) [![Coverage Status](https://img.shields.io/coveralls/firechicago/turf-cutter.svg)](https://coveralls.io/r/firechicago/turf-cutter?branch=master)

Turf Cutter is a prototype open-source voter-file management system for political campaigns.

Turf Cutter relies on a Sidekiq worker process to make asynchronous calls to the Mapbox and Google Maps geocoding APIs to provide latitude and longitude for voters.

If you want to run it locally you will need a .env file with the relevant keys:

MAPBOX_ACCESS_KEY="YOURKEYHERE"
GOOGLE_ACCESS_KEY="YOURKEYHERE"

You will also need a redis server and a running worker process, if you have performed a bundle install, you can run these from the command line with "redis-server" and "bundle exec sidekiq".

If you want to host a live version, see the docs for your hosting service on how to activate redis and sidekiq.
