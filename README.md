# Micro_Learning_App
Micro-Learning app is a responsive web application that sends you one page per day about something you want to learn. Could be: a new Language, a random Wikipedia page, React documentation, a page from the CIA World Factbook, anything!

Technologies Used
Ruby 2.4.1
Sinatra
Mysql
Sequel
Bundle

# Getting Started
Ensure that you have Ruby, Mysql Bundle installed.

Clone the application:

$ git clone https://github.com/ogomb/Micro_Learning_App.git
Change directory to Micro-Learning-App

$ cd Micro-Learning-Ap
Install gems by running

$ bundle install
Update the database configuration in database.yml with your correct prefferred settings. Make sure you have the database running.

Navigate to the root folder and Run
`sequel -m db/migrations/ mysql2://username:password@localhost/micro_learning`
to run migrations. username and password are your login details

Start the application by running: `ruby config.ru`
