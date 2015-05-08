class ContactsController < ApplicationController

	before_action :load_contact, except: [:index, :new, :create]

	def index
		if params
			@contacts = Contact.by_letter(params[:letter])
		else
			@contacts = Contact.all
		end
	end

	def show
	end

	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		if @contact.save
			redirect_to contact_path(@contact)
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @contact.update(contact_params)
			redirect_to contact_path(@contact)
		else
			render :edit
		end
	end

	def destroy
		@contact.delete
		redirect_to contacts_path
	end

	private

	def contact_params
		params.require(:contact).permit(:firstname, :lastname)
	end

	def load_contact
		@contact = Contact.find(params[:id])
	end
end
