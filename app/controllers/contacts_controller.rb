class ContactsController < ApplicationController

	def index
		# @contacts = Contact.all
		if params
			@contacts = Contact.by_letter(params[:letter])
		else
			@contacts = Contact.all
		end
	end

	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
		if @contact.save
			redirect_to contacts_path
		else
			render :new
		end
	end

	private

	def contact_params
		params.require(:contact).permit(:firstname, :lastname)
	end
end