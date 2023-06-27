# Star Wars API for Factored tech assesment

This Ris the repo to store the code for the back-end part of the technical assesment

## Pre-requisites

To run this project, you should have Ruby 3.1.0 and Rails 7.0.4, as well as sqlite3 (only if needed).

## Database

To recreate the database, please use:

``sqlite3 db/development.sqlite3 < db/dump/db.sql``

Then, you can seed the data:

``sqlite3 db/development.sqlite3 < db/dump/seed.sql``

Then, run the migrations:

``rails db:migrate``

## Tests
Before running tests, execute:

``sqlite3 db/test.sqlite3 < db/dump/db.sql``

And then, run the migrations:

``RAILS_ENV=test rails db:migrate``

To run the tests, you can use the command ``bundle exec rspec``. This project counts with models and controllers tests.

