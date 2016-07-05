#RD Segments

##Setup

###1. Required software

####PostgreSQL

Install Postgres from your nearest package manager, or use one of the (installers)[http://www.enterprisedb.com/products-services-training/pgdownload].

Create a role for the app, with a password (see postgres docs)!

###2. Environment variables

Remember to set the following variables before starting the server or using any rails/rake task:

 - `DATABASE_URL`: Path to the Postgres connection, usually something like "postgres://the_role"
 - `POSTGRES_USERNAME`, `POSTGRES_PASSWORD`: PostgreSQL database role credentials, if the URL doesn't provide them.

###3. Install gems

Run `bundle install` to install all dependency gems

###4. Database
Run `rails db:create db:migrate db:seed`

Drop into a `rails console` and manually create an Admin:

	# the password is protected, but the command line
	# may save a plaintext copy, so bear that in mind.
	Admin.new(email: "you@example.com", password: "somepass").save

###5. Run

Now that you're set up, run `rails server` and visit http://localhost:3000
