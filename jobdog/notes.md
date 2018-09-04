### Ideas

* Add icons to footer of front page like as featured on Oprah, Today Show, etc...

### ActiveRecord Models:

* User
* Job
* Bid
* Award

### Schema 

Users:

* email
* password digest
* session token

User_Profiles:

* user_id
* first_name
* last_name	
* location
* rating // maybe its own model
* skills // maybe its own model

Jobs:

* title
* description
* user_id
* category
* complete_by_date
* location
* status // 'open'/'awarded'/'complete'/'closed'

Bids:

* job_id
* bidder_id

(uniqness validation on the combo...bidders can only bid once per job)

Awards:

* job_id 
* recipient_id

(uniqness validation on job id)

Ratings

* rater_id
* rated_id
* job_id
* score
* comments

### Routes

name | method | url | action | filters
-----|--------|-----|--------|--------
        home | GET    | /home(.:format)                   | users#home 				| login
   edit_user | GET    | /edit(.:format)                   | users#edit 				| login 
     my_jobs | GET    | /my-jobs(.:format)                | jobs#my_jobs 			| login
   open_jobs | GET    | /open-jobs(.:format)              | jobs#open_jobs 		| login
     my_bids | GET    | /my-bids(.:format)                | bids#my_bids			| login
   my_awards | GET    | /my-awards(.:format)              | awards#my_awards  | login
	 close_job | PUT    | /jobs/:id/close(.:format)         | jobs#close_job    | login && user
-|-|-|-|-
user_profile | GET    | /users/:user_id/profile(.:format) | profiles#show 		| login
       users | POST   | /users(.:format)                  | users#create 			| none
    new_user | GET    | /users/new(.:format)              | users#new 				| none
        user | PUT    | /users/:id(.:format)              | users#update 			| login && owner
             | DELETE | /users/:id(.:format)              | users#destroy 		| login && owner
-|-|-|-|-
     session | POST   | /session(.:format)                | sessions#create 	| none
 new_session | GET    | /session/new(.:format)            | sessions#new 			| none
             | DELETE | /session(.:format)                | sessions#destroy 	| login
-|-|-|-|-
job_bids     | POST   | /jobs/:job_id/bids(.:format)      | bids#create				| login && owner
job_bid      | DELETE | /jobs/:job_id/bids/:id(.:format)  | bids#destroy			| login && owner
job_awards   | POST   | /jobs/:job_id/awards(.:format)    | awards#create			| login && owner
 job_award 	 | DELETE | /jobs/:job_id/awards/:id(.:format)| awards#destroy		|	login && owner
 edit_rating |GET     | /jobs/:id/rating/edit(.:format)   | ratings#edit      | login && owner
      rating |PUT     | /jobs/:id/rating(.:format)        | ratings#update    | login && owner
        jobs | GET    | /jobs(.:format)                   | jobs#index 				| login
             | POST   | /jobs(.:format)                   | jobs#create 			| login
     new_job | GET    | /jobs/new(.:format)               | jobs#new 					| login
    edit_job | GET    | /jobs/:id/edit(.:format)          | jobs#edit 				| login && owner
         job | GET    | /jobs/:id(.:format)               | jobs#show 				| login
             | PUT    | /jobs/:id(.:format)               | jobs#update 			| login && owner
             | DELETE | /jobs/:id(.:format)               | jobs#destroy 			| login && owner

### More Features

* Users rate each other after a job is closed
* Users have profiles which include:
	* rating
	* physical location
	* list of skills
* Users can search for jobs by category and location
* Jobs can have a price. Bids and awards also have a price
* Notifications on the user show page

### Advanced Features

* Emails are sent out to users based on job events
* Users can pay each other (paypal?)
* flashy UI
* user-to-user messages
* OAuth (login w/ google) 

### Technology

Rails:
 
* user auth
* CRUD
* associations
* forms
* routing
* views
* actionmailer
* 3rd party api (locations)

Javascript: 

* UI features 
* dynamic views with jquery 
* send/retrieving data with AJAX
* (potentially backbone?)
