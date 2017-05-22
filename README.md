## Tests
* I have both feature and unit tests
* I used the following for setting up the tests:
  * Rspec
  * Capybara
  * Webmock (to mock Yelp API calls)
  * DatabaseCleaner
  * FactoryGirl
* May seem like I overdid for the scope of the project, but I wanted to show that I can setup and use basic testing tools

## ENV Variables
* Required:
  * client_id
  * client_secret
* These are not required for running the tests but are required when running the app locally
* I use the Figaro gem. Run `bundle exec figaro install` to create an `application.yml` file and gitignore it

## Getting Started
```bash
git clone git@github.com:trevordjones/dia.git
cd dia
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:test:prepare # for good measure
bundle exec rspec spec # to run test suite
rails s # be sure ENV variables above are added
```
