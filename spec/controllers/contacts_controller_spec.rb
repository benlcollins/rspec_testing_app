# controller test

require 'spec_helper'
require 'rails_helper'

describe ContactsController do
	before :each do
		@contact = FactoryGirl.create(:contact)
	end

	describe "GET #index" do
		before :each do
			get :index
		end

		it "populates an array of contacts" do
			expect(assigns(:contacts)).to eq([@contact])
		end

		it "responds successfully with an HTTP status code 200" do
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the index template" do
			expect(response).to render_template(:index)
		end
	end

	describe "GET #show" do
		before :each do 
			get :show, id: @contact
		end

		it "assigns the chosen contact to @contact" do 
			expect(assigns(:contact)).to eq(@contact)
		end

		it "responds successfully with an HTTP status code 200" do
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the show template" do
			expect(response).to render_template(:show)
		end
	end

	describe "GET #new" do
		before :each do
			get :new
		end

		it "assigns new contact to @contact" do
			expect(assigns(:contact)).to be_a_new(Contact)
		end

		it "respondes successfully with an HTTP status code 200" do
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the new template" do
			expect(response).to render_template(:new)
		end
	end

	describe "POST #create" do
		context "valid attributes" do
			it "saves the new contact" do
				expect{ 
					post :create, contact: FactoryGirl.attributes_for(:contact) 
				}.to change(Contact, :count).by(1)
			end

			it "redirects to the the new contact page" do
				post :create, contact: FactoryGirl.attributes_for(:contact)
				expect(response).to redirect_to(Contact.last)
			end
		end

		context "with invalid attributes" do
			it "does not save the new contact" do
				expect{
					post :create, contact: FactoryGirl.attributes_for(:invalid_contact)
				}.to_not change(Contact,:count)
			end

			it "re-renders the new template" do
				post :create, contact: FactoryGirl.attributes_for(:invalid_contact)
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET #edit" do
		before :each do 
			get :edit, id: @contact
		end

		it "assigns the chosen contact to @contact" do 
			expect(assigns(:contact)).to eq(@contact)
		end

		it "responds successfully with an HTTP status code 200" do
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it "renders the show template" do
			expect(response).to render_template(:edit)
		end
	end

	describe "PUT #update" do
		before :each do
			@peterjones = FactoryGirl.create(:contact, firstname: "Peter", lastname: "Jones")
		end

		context "valid attributes" do
			it "locates the contact" do
				put :update, id: @peterjones, contact: FactoryGirl.attributes_for(:contact)
				expect(assigns(:contact)).to eq(@peterjones)
			end

			it "updates the contact correctly" do
				put :update, id: @peterjones, 
					contact: FactoryGirl.attributes_for(:contact, firstname: "Pedro", lastname: "Jones")
				@peterjones.reload
				expect(@peterjones.firstname).to eq("Pedro")
				expect(@peterjones.lastname).to eq("Jones")
			end

			it "redirects to the updated contact page" do
				put :update, id: @peterjones, contact: FactoryGirl.attributes_for(:contact)
				expect(response).to redirect_to(contact_path)
			end
		end

		context "invalid attributes" do
			it "locates the contact" do
				put :update, id: @peterjones, contact: FactoryGirl.attributes_for(:invalid_contact)
				expect(assigns(:contact)).to eq(@peterjones)
			end

			it "does not update the contact" do
				put :update, id: @peterjones, 
					contact: FactoryGirl.attributes_for(:contact, firstname: "Pedro", lastname: nil)
				@peterjones.reload
				expect(@peterjones.firstname).not_to eq("Pedro")
				expect(@peterjones.lastname).to eq("Jones")
			end

			it "re-renders the edit page" do
				put :update, id: @peterjones, contact: FactoryGirl.attributes_for(:invalid_contact)
				expect(response).to render_template(:edit)
			end
		end
	end

	describe "DELETE #destroy" do
		it "deletes the contact from the database" do
			expect{ 
				delete :destroy, id: @contact
			}.to change(Contact, :count).by(-1)
		end

		it "redirects to the index page" do
			delete :destroy, id: @contact
			expect(response).to redirect_to(contacts_path)
		end
	end


end