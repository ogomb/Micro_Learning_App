[![Build Status](https://travis-ci.org/ogomb/Micro_Learning_App.svg?branch=master)](https://travis-ci.org/ogomb/Micro_Learning_App)[![Coverage Status](https://coveralls.io/repos/github/ogomb/Micro_Learning_App/badge.svg?branch=master)](https://coveralls.io/github/ogomb/Micro_Learning_App?branch=master)


# Micro_Learning_App
Micro-Learning app is a responsive web application that sends you one page per day about something you want to learn. Could be: a new Language, a random Wikipedia page, React documentation, a page from the CIA World Factbook, anything!

Application is hosted in heroku https://micro-learning-challenge.herokuapp.com/login

## Technologies Used
- `Ruby`
- `Sinatra`
- `Postgres`
- `Send-grid`
- `Active Record`
- `Rake`
- `Bundle`
- `Bcrypt`
- `Whenever`

## Getting Started
Ensure that you have `Ruby and Postgres` installed.

- Clone the application:
      `git clone https://github.com/ogomb/Micro_Learning_App.git`
      
- Change directory to Micro-Learning-App  `cd Micro-Learning-App`

- Install gems by running   `bundle install`

- Create database  `rake db:create`

- Run Migrations   `rake db:migrate`

- Prepare the test database`rake db:test:prepare`

- Start the application by running: `rackup`
