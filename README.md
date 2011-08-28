Welcome to Bloody CMS
=====================

BLoody CMS is a very simple CMS optimised for event organisers written in Rails 3.1. The goal is to build a lot of the common elements needed for running events (ticketing, sponsors, etc) into the system as modules that can be enabled on demand.

Simple installation instructions
--------------------------------

Clone the git repository.

    $ git clone git://github.com/cbetta/Bloody-CMS.git
    
Run bundler to install all gems.

    $ bundle install --without=production

Copy a new database.yml file.

    $ cp config/database.yml.example config/database.yml

Run your database migrations .

    $ rake db:migrate

Run the rails server.

    $ rails server

Now you can visit http://127.0.0.1:3000 and fill in your site name and Twitter authentication key and secret. You will be sent through Twitter to authenticate your own Twitter account as a first user and admin.

That's it, you're done and can start adding pages.

Deploying to Heroku
-------------------

First perform the simple installation instructions above. 

Next up run the Heroku command to create a new app.

    $ heroku create 

Now because we are using Rails 3.1 which has a new assets pipeline that's not fully supported by Heroku, we will have to precompile and commit our assets.

    $ rake assets:precompile
    $ git add public/assets/*
		$ git commit -m "Compiled assets"

Now push your app to Heroku.

    $ git push heroku master

And migrate your remote database.

    $ heroku rake db:migrate

To speed up you app, add the free memcache add-on on Heroku:

    $ heroku addons:add memcache 

Boom, you're done. Now you can visit your site's Heroku URL and setup the configuration the same way you did as on local setup.

History 
-------
* August 27, 2011 - v0.1.0 - Added sponsors module and coincidently finished bloody cms basics for first release to production
* August 27, 2011 - v0.0.9 - Pushed events a bit early. Did lots of fixes.
* August 27, 2011 - v0.0.8 - Added event module with ticketing
* August 23, 2011 - v0.0.7 - Added Twitter avatars and usernames to blog posts
* August 23, 2011 - v0.0.6 - Added configuration UI for promoting a user to admin
* August 22, 2011 - v0.0.5 - Added the last bits for the blog module
* August 22, 2011 - v0.0.4 - Added memcache support for the options model
* August 2, 2011 - v0.0.3 - Added installation instructions and made sure it actually works as described
* August 2, 2011 - v0.0.2 - Rewritten the configuration of the app to be using the DB and a UI rather than a config YAML file


Roadmap
-------

* Allow the admin to sorting the pages and elements in the sidebar
* Add a sponsorship module
* Add a commenting module
* Add a gravatar module for comments
* Add a map module
* Add a ticketing module that integrates with Eventbrite
* Add a links module
* Add automatic and manual sharing of new posts to social sites 
* Allow a site to link back to a parent site

Disclaimer
----------

* Simplistica icons by http://dryicons.com/free-icons/preview/simplistica/



