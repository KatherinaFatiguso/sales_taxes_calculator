# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
	ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux]
	Rails 6.0.4.4

* System dependencies

* Configuration
	Save this app 'sales_tax_calculator' on your directory, then go to the root directory of the app.
	Run local server in terminal: rails s
	Open in browser: localhost:3000
	To run the gems bundler, run in terminal: bundle install
	To run the migration, run in terminal: bundle exec rails db:migrate

	Find the provided three samples of CSV file in the root directory of the app (input_1.csv, input_2.csv, input_3.csv).
	If user click on the link to calculate the sales taxes of the purchases, the result will be written in a file and saved in the folder 'sales_taxes_files' in the root directory.
	The file name will include the timestamp of when it was created.

* Database creation

* Database initialization

* How to run the test suite
	In your terminal in the root directory, run the unit tests: bundle exec rake test

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
