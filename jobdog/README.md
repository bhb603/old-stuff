# JobDog

Inspired by [TaskRabbit](https://www.taskrabbit.com).

Visit the live app @ [jobdog.brianbuchholz.com](http://jobdog.brianbuchholz.com).

## About the App

There are two ways to use JobDog:

If you need help with a job:

1. Post the job and wait for other users to bid on it
2. Award the job to the user you deem fit
3. After the awarded user performs the job, rate the user and the job will be closed
4. Celebrate as your to-do list dwindles!

If you want to help others do jobs:

1. Search for nearby jobs; bid on those which match your skills
2. If awarded a job, complete it by the required date
3. Get rated and repeat!

## Development

Jobdog runs on Rails 3.2 and is hosted on [Heroku](http://heroku.com). 

Technology includes: 

* User authentication using [Google OAuth 2.0](https://developers.google.com/)
* Location based job searches using [Google geocoding api](https://developers.google.com/)
* Interactive mapping with [Mapbox](https://mapbox.com)

## Todo

* optimize db queries
* integrate Backbone.js into the Jobs index and Job show page for a single-page experience
* setup email notifications with Sendgrid
* use Pusher to update user notifications in real-time
* setup a pending rating reminder 
* users have skills which can be used to automatically match jobs by category
* add google calendar api for scheduling jobs
* let users can change password, forget password, etc
* refactor "My Jobs" page to include both jobs you own and jobs you've been awarded, with available actions for each
* "How it Works" page


