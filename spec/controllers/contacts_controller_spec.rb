# controller test

require 'spec_helper'
require 'rails_helper'

describe ContactsController do
	before :each do
		@contact = FactoryGirl.create(:contact)
	end

	describe "GET #index" do
		it "populates an array of contacts" do
			get :index
			expect(assigns(:contacts)).to eq([@contact])
		end

		it "responds successfully with an HTTP status code 200" do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200)
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
	end

end