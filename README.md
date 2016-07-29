
# Mars Rover Image Explorer

Practising to learn Ruby On Rails by creating this little app that retrieves images from one of three Mars Rovers:
- Curiosity
- Opportunity
- Spirit

Requirements
- Ruby version v2.3.1 (setup using [rbenv](https://github.com/rbenv/rbenv))
- Ruby on Rails v4.2.6
- Postgres v9.5.3

Uses
- NASA's [Rover API](https://api.nasa.gov/api.html#MarsPhotos). They also have a bunch of other really cool APIs!

## Setup

Cd in to repository, then run the migration script

    rake db:migrate
    
Start server

    bin/rails server

Once the server has been activated, you can go to

    http://localhost:3000
    
Images are queried by entering a sol date (an integer value for X number of days on Mars) and a Rover.
