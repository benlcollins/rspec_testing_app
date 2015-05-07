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
				expect{ post :create, contact: FactoryGirl.attributes_for(:contact) }.to change(Contact, :count).by(1)
			end

			it "redirects to the index template" do
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

			it "renders the new template again" do
				post :create, contact: FactoryGirl.attributes_for(:invalid_contact)
				expect(response).to render_template(:new)
			end
		end
	end

	describe "DELETE #destroy" do
	
	end


end