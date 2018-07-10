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

- Start the application by running: `rackup`
