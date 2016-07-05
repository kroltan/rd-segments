#RD Segments

##Setup

###1. Environment variables

Remember to set the following variables before starting the server or using any rails/rake task:

 - `POSTGRES_USERNAME`, `POSTGRES_PASSWORD`: PostgreSQL database role credentials

###2. Database
Run `rails db:create db:migrate`

Drop into a `rails console` and manually create an Admin:

	# the password is protected, but the command line
	# may save a plaintext copy, so bear that in mind.
	Admin.new(email: "you@example.com", password: "somepass").save

