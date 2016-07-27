
Ruby version: 2.3.1,
Postgres

# Mars Rover Image Explorer

Practising to learn Ruby On Rails by creating this little app that retrieves images from one of three Mars Rovers:
- Curiosity
- Opportunity
- Spirit

## Setup

1. Migrate

    rake db:migrate
    
2. Start server

    bin/rails server

Once the server has been activated, you can go to

    http://localhost:3000/images
    
Images are queried by entering a sol date (an integer value representing the number of days the rover has been on Mars) and a Rover.
