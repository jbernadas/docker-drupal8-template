==========
Docker - Drupal 8 Continuous Integration
==========

This is a template for building containerized Drupal 8 websites with persistent volumes and is suitable for continuous integration. It uses Composer for dependency management and Git for version control.

Operating systems: Tested on Mac OS and Linux only.

Requirements: You need to have Docker and Docker Compose installed.

This uses Drupal 8, MySQL, Apache2 and PHP 7.3.

Sharing the same database across development teams only requires creating a database dump and then versioning it.

To use, simply download it to your development environment by issuing the following command:
::
  git clone https://github.com/jbernadas/drupal8-ci-template.git <your directory name here>

You can now cd into the directory that has been created:
::
  cd <your directory name here>

You can now run Docker Compose to download the images and build the container. Issue the following command:
::
  docker-compose up -d --build

Once it is finished building, you can now see your containers by issuing the command below. Make a note of the name of your containers:
::
  docker ps

Change the owner of the newly created app directory by issuing:
::
  sudo chown -R <your username>:<your groupname (same as user name)> app

We can now go into our container's bash terminal by issuing the below command:
::
  docker exec -it <name of your container> bash

You will be dropped inside your drupal-apache container as root. We can now install Drupal 8 by issuing the below command:
::
  composer create-project drupal-composer/drupal-project:8.x-dev /app --stability dev --no-interaction

Create the config/sync directory
::
  mkdir -p /app/config/sync

Recursively change the owner of the /app/web directory to Apache user and group
::
  chown -R www-data:www-data /app/web

Go to localhost:<port number in your docker-compose.yml file> and configure your Drupal 8 site. Remember to put the correct container name in the host section of database credentials.

Comment out the lines /web/sites/*/settings.php and /web/sites/*/files/ in the main .gitignore inside the app directory. This will our site settings and files will have the same config across all dev teams.

Use Drush to export your Drupal configuration
::
  drush config-export
  exit

VERY IMPORTANT NOTE: If you use this on a production environment, please don't forget to update your main .gitignore file so that the settings.php and files line is uncommented out.