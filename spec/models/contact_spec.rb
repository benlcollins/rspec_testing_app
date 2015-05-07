# contact model test

require 'spec_helper'
require 'rails_helper'

describe Contact do
	it "has a valid factory" do
		# .should method now deprecated
		# FactoryGirl.create(:contact).should be_valid  <-- works, but is old way of doing this
		expect(FactoryGirl.create(:contact)).to be_valid
	end

	it "is invalid without a firstname" do
		expect(FactoryGirl.build(:contact, firstname: nil)).not_to be_valid
	end

	it "is invalid without a lastname" do
		expect(FactoryGirl.build(:contact, lastname: nil)).not_to be_valid
	end

	it "returns a contact's full name as a string" do
		contact = FactoryGirl.create(:contact)
		# expect(contact.name).to eq("John Doe")   <-- this doesn't work because of Faker gem data

		# check string and has two words
		expect(contact.name.class).to eq(String)
		expect(contact.name.split(" ").length).to eq(2)
	end

	# test that clicking on letter returns only contacts whose surnames begin with that letter
	describe "filter last name by letter" do
		before :each do 
			# need to create test names, where at least two start with same letter and one doesn't
			@jones = FactoryGirl.create(:contact, lastname: "Jones")
			@james = FactoryGirl.create(:contact, lastname: "James")
			@smith = FactoryGirl.create(:contact, lastname: "Smith")
		end

		context "matching letters" do
			it "it returns contacts starting with same letter" do
				expect(Contact.by_letter("J")).to match_array([@jones, @james])
			end
		end

		context "non-matching letters" do
			it "it does not return contacts starting with a different letter" do
				expect(Contact.by_letter("J")).not_to match_array([@smith])
			end
		end
	end
end