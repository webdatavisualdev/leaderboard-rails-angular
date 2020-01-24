# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

A simple ruby script for mocking live leaderboard data. Running the script will update the leaderboard data every 0.5s and post the leaderboard as json to http://localhost:3000/receiver/leaderboard/FT7E3Y68UPA6

To run the script simply `cd` to the enclosing folder and run `ruby mock_leaderboard_data.rb` it will keep running forever so close it when `cmd^c` or `ctrl^c` when you're done.