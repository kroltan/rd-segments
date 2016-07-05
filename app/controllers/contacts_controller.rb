class ContactsController < ApplicationController
	before_action :authenticate_admin!

	def index
		page_size = Rails.configuration.paging["contacts"]
		@contacts = Contact.all
			.limit(page_size)
			.offset(page_size * params.fetch(:page, 0))
	end
	
	def show
		@contact = Contact.find(params[:id])
	end

	def new
		@contact = Contact.new
	end

	def edit
		@contact = Contact.find(params[:id])
	end

	def create
		@contact = Contact.new(contact_params)
		if @contact.save
			redirect_to @contact
		else
			render 'new'
		end
	end

	def update
		@contact = Contact.find(params[:id])
		if @contact.update(contact_params)
			redirect_to @contact
		else
			render 'edit'
		end
	end

	def destroy
		@contact = Contact.find(params[:id])
		@contact.destroy

		redirect_to contacts_path
	end

	private
	def contact_params
		params.require(:contact).permit(:name, :email, :age, :state_id, :role)
	end
end
